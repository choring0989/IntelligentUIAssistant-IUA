from firebase import Firebase
import firebase_admin
from firebase_admin import storage
from firebase_admin import credentials

cred = credentials.Certificate(
    "C:/Users/이슬이/Documents/intelligentuiassistant-iua-firebase-adminsdk-in0kt-f3a89fbb76.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://intelligentuiassistant-iua.firebaseio.com',
    'storageBucket': 'intelligentuiassistant-iua.appspot.com',
})

bucket_name = 'intelligentuiassistant-iua.appspot.com'
source_blob_name = 'images/117뀨꺄.png'
destination_file_name = 'edit_test/new.png'
blob = storage.bucket(bucket_name).blob(source_blob_name)
blob.download_to_filename(destination_file_name)
print(blob.public_url) # prints https://storage.googleapis.com/my-app-name.appspot.com/a.jpg

