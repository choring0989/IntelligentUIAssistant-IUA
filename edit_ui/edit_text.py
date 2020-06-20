import cv2
import pytesseract
from pytesseract import Output
import numpy as np

def main(img):
    # kernel for sharpening
    kernel_sharpen = np.array(
        [[-1, -1, -1, -1, -1], [-1, 2, 2, 2, -1], [-1, 2, 8, 2, -1], [-1, 2, 2, 2, -1], [-1, -1, -1, -1, -1]]) / 8.0
    # 정규화위해 8로나눔

    origin = cv2.imread('input_text/'+img)

    origin = cv2.resize(origin, None, fx=2.5, fy=2.5)
    sharpen = cv2.filter2D(origin, -1, kernel_sharpen)

    image = cv2.cvtColor(sharpen, cv2.COLOR_BGR2GRAY)
    _, image = cv2.threshold(image, 100, 255, cv2.THRESH_BINARY)

    d = pytesseract.image_to_data(image, output_type=Output.DICT)

    n_boxes = len(d['text'])
    for i in range(n_boxes):
        if int(d['conf'][i]) > 60:
            (x, y, w, h) = (d['left'][i], d['top'][i], d['width'][i], d['height'][i])

            # print(x,y)
            r, g, b = sharpen[y - 5, x - 5]
            r = int(r)
            g = int(g)
            b = int(b)
            image = cv2.rectangle(sharpen, (x - 5, y - 5), (x + w + 5, y + h + 5), (r, g, b), -1)

    cv2.imwrite('output_text/'+img, image)


