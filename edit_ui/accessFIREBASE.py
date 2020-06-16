import firebase_admin
from firebase_admin import storage
from firebase_admin import credentials
from google.cloud import storage as st

cred = credentials.Certificate(
    "C:/Users/이슬이/Documents/intelligentuiassistant-iua-firebase-adminsdk-in0kt-f3a89fbb76.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://intelligentuiassistant-iua.firebaseio.com',
    'storageBucket': 'intelligentuiassistant-iua.appspot.com',
})

bucket_name = 'intelligentuiassistant-iua.appspot.com'

storage_client = st.Client()

#Firebase storage 내에 있는 객체 목록 가져오기
blobs = storage_client.list_blobs(bucket_name)
img_list = []

for b in blobs:
    if b.name.split("/")[0] == 'images':
        img_list.append(b.name.split("/")[1])
        
#타임스탬프가 가장 최근에 찍힌 파일 찾기
img_list = sorted(img_list, reverse=True)
source_blob_name = 'images/'+img_list[0]
destination_file_name = 'edit_test/'+img_list[0]
print(source_blob_name)
#유저가 가장 최근에 올린 파일을 서버에 저장
blob = storage.bucket(bucket_name).blob(source_blob_name)
blob.download_to_filename(destination_file_name)
print(blob.public_url)

#결과물 서버로 재전송
upload_file_name = 'output/'+img_list[0]
blob = storage.bucket(bucket_name).blob(upload_file_name)
blob.upload_from_filename(destination_file_name)

