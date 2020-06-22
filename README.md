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
This project utilized the code here. [Mask-RCNN](https://github.com/matterport/Mask_RCNN)

- Train Model-train.ipynb
 1. Prepare the custom dataset.
 - After labeling each image, save it to a dataset file.(train/val)
 - Use this link to proceed with labeling.[Labeling](http://www.robots.ox.ac.uk/~vgg/software/via/via-1.0.6.html)
 
 <img src="./image/img11.PNG" width="420" height="300">
 
 2. Install tensorflow-gpu = 1.15.0 and keras=2.2.5.
 > pip install tensorflow-gpu==1.15.0<br>
 > pip install keras==2.2.5<br>
 
 3. Train Custom Dataset
 > python ui.py train --dataset='path of dataset' --weights=coco  
  
- Validate Model-validation.ipynb
Visualize the detection result. We chose the three most accurate models.

<img src="./image/img10.PNG" width="420" height="300">

### Example Code
### Execution Screen

1. Upload the image you want to separate the UI components. And choose one of the pre-learned models.

<img src="./image/img2.png" width="420" height="200" ><img src="./image/img3.png" width="420" height="200">

2. The detection result can be checked after loading time. 

<img src="./image/img4.png" width="290" height="150"><img src="./image/img5.png" width="290" height="150"><img src="./image/img6.png" width="290" height="150">

3. Press the download button to receive the results in the zip file format.
## Deleteing Text Inside UI Component

From the user-entered UI component, it recognizes text part using OCR and removes the text.<br>

### Tesseract-ORC
### Example Code
### Execution Screen

1. If you enter ui component, you can see that the letters disappeared from  after loading.<br>

<img src="./image/img7.png" width="290" height="150"><img src="./image/img8.png" width="290" height="150"><img src="./image/img9.png" width="290" height="150">

2. Press the download button to receive the results in the zip file format.
