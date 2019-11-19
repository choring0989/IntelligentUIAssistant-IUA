#!/usr/bin/env python
# coding: utf-8

# In[7]:


import cv2 as cv
import numpy as np
def setLabel(image, str, contour):
    (text_width, text_height), baseline = cv.getTextSize(str, cv.FONT_HERSHEY_SIMPLEX, 0.7, 1)
    x,y,width,height = cv.boundingRect(contour)
    pt_x = x+int((width-text_width)/2)
    pt_y = y+int((height + text_height)/2)
    cv.rectangle(image, (pt_x, pt_y+baseline), (pt_x+text_width, pt_y-text_height), (200,200,200), cv.FILLED)
    cv.putText(image, str, (pt_x, pt_y), cv.FONT_HERSHEY_SIMPLEX, 0.7, (0,0,0), 1, 8)

def im_trim (img,x,y,w,h): #함수로 만든다 
    img_trim = img[y:y+h, x:x+w] #trim한 결과를 img_trim에 담는다 
    #cv.imwrite('org_trim.jpg',img_trim) #org_trim.jpg 라는 이름으로 저장 
    cv.imshow('part', img_trim)
    cv.waitKey(0)
    return img_trim #필요에 따라 결과물을 리턴 

img_color = cv.imread('ex2.png', cv.IMREAD_COLOR)
cv.imshow('img_color', img_color)
cv.waitKey(0)


#이미지 전처리
img_gray = cv.cvtColor(img_color, cv.COLOR_BGR2GRAY)
#cv.imshow('img_gray', img_gray)
cv.waitKey(0)

#img_hsv = cv.cvtColor(img_gray, cv.COLOR_BGR2HSV)
#cv.imshow('img_hsv', img_hsv)
#cv.waitKey(0)
 
#edged = cv.Canny(blurred, 30, 150)
#cv.imshow("edged", edged)
#cv.waitKey(0)

#이미지 선명하게 처리
kernel = np.array([[-1, -1, -1], [-1, 9, -1], [-1, -1, -1]])
sharpen = cv.filter2D(img_gray, -1, kernel)
#cv.imshow('sharpen', sharpen)
#cv.waitKey(0)

ret,img_binary = cv.threshold(img_gray, 127, 255, cv.THRESH_BINARY_INV|cv.THRESH_OTSU)
#cv.imshow('img_binary1', img_binary)
#cv.waitKey(0)


#윤곽선 선명하게 처리
img_thres = cv.adaptiveThreshold(img_gray, 255, cv.ADAPTIVE_THRESH_GAUSSIAN_C, cv.THRESH_BINARY_INV, 11, 2)
#img_thres = cv.adaptiveThreshold(img_gray, 255, cv.ADAPTIVE_THRESH_GAUSSIAN_C, cv.THRESH_BINARY, 11, 2)
#cv.imshow('img_binary2', img_thres)
#cv.waitKey(0)

#2,2는 깔끔하기는 한데... 첫번째 예제에서 너무 많이 잘라버림..
#분리를 위해서 사용
kernel = np.ones((2,2), np.uint8)
erd = cv.erode(img_thres, kernel, iterations = 1)
#cv.imshow('img_erode', erd)
#cv.waitKey(0)



#kernel 사이즈를 조절해서 글자크기 or 작은 사이즈의 글자들을 마스킹 할 수 있다.
kernel = np.ones((10,30), np.uint8)
img_binary_morph = cv.morphologyEx(erd, cv.MORPH_CLOSE, kernel)
#cv.imshow('img_binary_morph', img_binary_morph)
#cv.waitKey(0)

#흐릿하게 하는 거
#blurred = cv.GaussianBlur(img_gray, (5, 5), 0)
#cv.imshow("blurred", blurred)
#cv.waitKey(0)

#contours, hierarchy = cv.findContours(erd, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
contours, hierarchy = cv.findContours(img_binary_morph, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)

for cnt in contours:
    size = len(cnt)
    #print(size)

    epsilon = 0.005 * cv.arcLength(cnt, True)
    approx = cv.approxPolyDP(cnt, epsilon, True)

    size = len(approx)
    #print(size)

   # cv.line(img_color, tuple(approx[0][0]), tuple(approx[size-1][0]), (0, 255, 0), 3)
    for k in range(size-1):
        #-cv.line(img_color, tuple(approx[k][0]), tuple(approx[k+1][0]), (0, 255, 0), 3)
        x,y,w,h = cv.boundingRect(cnt)
        cv.rectangle(img_color, (x, y), (x+w, y+h), (255,0,0),5)
    trim_image=im_trim(img_color,x,y,w,h)
    
    

cv.imshow('result', img_color)
cv.waitKey(0)


# In[ ]:





# In[ ]:





# In[ ]:




