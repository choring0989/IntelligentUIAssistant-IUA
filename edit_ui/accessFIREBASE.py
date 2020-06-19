import firebase_admin
from firebase_admin import storage
from firebase_admin import credentials
from google.cloud import storage as st
import os
import asyncio
import websockets
# 클라이언트 접속이 되면 호출된다.
async def accept(websocket, path):
    while True:
        # 클라이언트로부터 메시지를 대기한다.
        client_bla = await websocket.recv()

        img_name = client_bla.split("&")[0]
        model_name = client_bla.split("&")[1]

        source_blob_name = 'images/' + img_name
        destination_file_name = 'input/' + img_name
        # 유저가 가장 최근에 올린 파일을 서버에 저장
        blob = storage.bucket(bucket_name).blob(source_blob_name)
        blob.download_to_filename(destination_file_name)
        print(blob.public_url)

        zipDIR = 'C:/Users/이슬이/Documents/GitHub/IntelligentUIAssistant-IUA/edit_ui/output/'+img_name.split(".")[0]

        # zip 파일을 저장할 디렉토리 생성
        try:
            if not os.path.exists(zipDIR):
                os.makedirs(zipDIR)
        except OSError:
            print("dir error")

        import seperate_ui
        seperate_ui.main("model/"+model_name, img_name)

        import zipfile
        with zipfile.ZipFile(zipDIR+'/output.zip', 'w') as myZip:
            # 압축 대상 경로
            des_folder = zipDIR
            # os 모듈로 해당 경로의 파일을 취득한다.(os.walk는 경로의 하위 폴더까지 취득한다.)
            for folder, subfolders, files in os.walk(des_folder):
            # os.walk로 파일 리스트를 받아 루프를 돌린다.
                for file in files:
                # folder와 files명은 다른 변수로 취득된다. 두 변수값으로 파일 절대 경로를 만든다.
                    full_name = os.path.join(folder, file);
                    # write은 압축 파일에 파일을 쓰는 것이다. 파라미터는 대상 파일, 저장될 경로로 지정된다.
                    # 압축 파일에 저장될 경로는 \기준으로 상대 경로로 작성해야 한다.
                    myZip.write(full_name, os.path.relpath(full_name, des_folder));

        # 결과물 서버로 재전송
        upload_file_name = 'output/' + img_name
        blob = storage.bucket(bucket_name).blob(upload_file_name)
        blob.upload_from_filename('output/' + img_name)

        upload_file_name = 'zip/' + img_name.split(".")[0] + ".zip"
        blob = storage.bucket(bucket_name).blob(upload_file_name)
        blob.upload_from_filename(zipDIR+'/output.zip')

        # 클라이언트에 처리 완료 알림
        await websocket.send("success");

# 파이어베이스 인증
cred = credentials.Certificate(
    "C:/Users/이슬이/Documents/intelligentuiassistant-iua-firebase-adminsdk-in0kt-f3a89fbb76.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://intelligentuiassistant-iua.firebaseio.com',
    'storageBucket': 'intelligentuiassistant-iua.appspot.com',
})

bucket_name = 'intelligentuiassistant-iua.appspot.com'
storage_client = st.Client()

start_server = websockets.serve(accept, "localhost", 9998);
# 비동기로 서버를 대기한다.
asyncio.get_event_loop().run_until_complete(start_server);
asyncio.get_event_loop().run_forever();