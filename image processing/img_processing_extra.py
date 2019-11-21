#!/usr/bin/env python
# coding: utf-8

# In[10]:


import cv2 as cv
import numpy as np

def img_separate(img,x,y,w,h,num):
    img_sep = img[y:y+h, x:x+w] #분리한 이미지를 담는다. 
    #cv.imwrite('part'+str(num)+'.png',img_sep) #part.png 라는 이름으로 저장 
    cv.imshow('part', img_sep)
    cv.waitKey(0)
    return img_sep #필요에 따라 결과물을 리턴 

def rectangle_contour(filename):
    img_color = cv.imread(filename)
    cv.imshow('img_color', img_color)
    cv.waitKey(0)
    #grey scale
    imag_gray = cv.cvtColor(img_color, cv.COLOR_BGR2GRAY)  

    block_size = 11  # 픽셀에 적용할 threshold값을 계산하기 위한 블럭 크기. 적용될 픽셀이 블럭의 중심이 됨. 따라서 blocksize 는 홀수여야 함
    subtract_val = 2  # 보정 상수
    adaptive_gaussian_image = cv.adaptiveThreshold(imag_gray, 255, cv.ADAPTIVE_THRESH_GAUSSIAN_C,cv.THRESH_BINARY,  block_size, subtract_val)
        
        
    kernel = np.ones((4,4), np.uint8)
    erd = cv.erode(adaptive_gaussian_image, kernel, iterations = 1)

    #kernel 사이즈를 조절해서 글자크기 or 작은 사이즈의 글자들을 마스킹 할 수 있다.
    kernel = np.ones((20,20), np.uint8)
    iteration= 1
    img_binary_morph = cv.morphologyEx(erd, cv.MORPH_OPEN, kernel,iteration)
    #cv.imshow('check', img_binary_morph)
    #cv.waitKey(0)

    # contours는 point의 list형태.
    # hierarchy는 contours line의 계층 구조
    # Threshold 적용한 이미지에서 contour 들을 찾아서 contours 변수에 저장하기
    contours,hierarchy = cv.findContours(img_binary_morph, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
    
    num=0

    for cnt in contours:
        size = len(cnt)
        #print(size)

        epsilon = 0.005 * cv.arcLength(cnt, True)
        approx = cv.approxPolyDP(cnt, epsilon, True)

        size = len(approx)
        #print(size)
        x, y, w, h = cv.boundingRect(cnt)  # 좌상단 꼭지점 좌표 , width, height
        if w>10 and h>10:
            #sep_image=img_separate(img_color,x,y,w,h,num)
            num+=1
            cv.rectangle(img_color, (x, y), (x+w, y+h), (255,0,0), 2)  # 원본 이미지 위에 사각형 그리기! 
 
        
    cv.imshow('result', img_color)
    cv.waitKey(0)

rectangle_contour('ex2.png')


# In[ ]:





# In[ ]:




