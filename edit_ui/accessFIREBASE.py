import firebase_admin
from firebase_admin import storage
from firebase_admin import credentials
from google.cloud import storage as st

import asyncio
import websockets
# 클라이언트 접속이 되면 호출된다.
async def accept(websocket, path):
    while True:
        # 클라이언트로부터 메시지를 대기한다.
        client_bla = await websocket.recv()

        img_name = client_bla.split("&")[0]
        model_name = client_bla.split("&")[1]
        print("img:" + img_name)
        print("model:" + model_name)

        source_blob_name = 'images/' + img_name
        destination_file_name = 'input/' + img_name
        print(source_blob_name)
        # 유저가 가장 최근에 올린 파일을 서버에 저장
        blob = storage.bucket(bucket_name).blob(source_blob_name)
        blob.download_to_filename(destination_file_name)
        print(blob.public_url)

        import seperate_ui
        seperate_ui.main("model/"+model_name, img_name)

        # 결과물 서버로 재전송
        upload_file_name = 'output/' + img_name
        blob = storage.bucket(bucket_name).blob(upload_file_name)
        blob.upload_from_filename('output/' + img_name)

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