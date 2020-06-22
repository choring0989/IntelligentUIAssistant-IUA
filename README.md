# IntelligentUIAssistant-IUA
IUA is a web application that mainly performs the task of separating the UI of graphic components.<br>

![main_screen](./image/img1.png)
### The server environment for execution is:<br>
> * Python 3.6<br>
> * tensorflow-gpu 1.15.0<br>
> * keras 2.2.5<br>
> * openCV 4.1.0<br>
> * tesseract-orc v5.0.0<br>
> * firebase_admin 4.3.0<br>
> * Python google.cloud<br>
> * Python websockets<br>
> * Python zipfile37<br>
### Used library:<br>
> * numpy<br>
> * scipy<br>
> * Pillow<br>
> * cython<br>
> * matplotlib<br>
> * pytesseract<br>
> * scikit-image<br>
> * tensorflow>=1.3.0<br>
> * keras>=2.0.8<br>
> * opencv-python<br>
> * h5py<br>
> * imgaug<br>
> * IPython[all]<br>
## UI Component Separation
The UI components of the image entered by the user are automatically separated using the learned model.<br>
### UI Detection<br>
To detect UI, we used Mask R-CNN among object detection models.<br>
#### Mask R-CNN
### Example Code
### Execution Screen

<img src="./image/img2.png" width="400" height="200"><img src="./image/img3.png" width="400" height="200">


## Deleteing Text Inside UI Component

From the user-entered UI component, it recognizes text part using OCR and removes the text.<br>

### Tesseract-ORC
### Example Code
### Execution Screen

If you enter ui component, you can see that the letters disappeared from  after loading.<br>

<img src="./image/img7.png" width="300" height="190"><img src="./image/img8.png" width="300" height="190"><img src="./image/img9.png" width="300" height="190">

