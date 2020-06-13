import pyrebase
from firebase import Firebase

import firebase_admin
from firebase_admin import storage
from firebase_admin import credentials

cred = credentials.Certificate("C:/Users/이슬이/Documents/intelligentuiassistant-iua-firebase-adminsdk-in0kt-f3a89fbb76.json")
firebase_admin.initialize_app(cred, {
  'databaseURL': 'https://intelligentuiassistant-iua.firebaseio.com',
  'storageBucket': 'intelligentuiassistant-iua.appspot.com',
})
file = 'edit_result/edit.png'
blob = storage.bucket('intelligentuiassistant-iua.appspot.com').blob(file)
blob.upload_from_filename(file)
print(blob.public_url) # prints https://storage.googleapis.com/my-app-name.appspot.com/a.jpg
