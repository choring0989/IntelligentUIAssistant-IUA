import cv2
import numpy as np

global clone, flag
clone = None
# 글자 설정
color = (255, 0, 255)
text = 'Check text!'
font = cv2.FONT_HERSHEY_SCRIPT_SIMPLEX
fontScale = 1.5
thickness = 2


def MouseLeftClick(event, x, y, flags, param):
    # 왼쪽 마우스가 클릭되면 (x, y) 좌표를 저장한다.
    if event == cv2.EVENT_LBUTTONDOWN:
        # 원본 파일을 가져 와서 clicked_points에 있는 점들을 그린다.
        image = clone.copy()
        flag = True
        px = x
        py = y
        cv2.putText(image, text, (x, y), font, fontScale, color, thickness)
        cv2.imshow("image", image)
        cv2.imwrite('edit_result/edit.png', image)

    # 수정하고 싶은 이미지 경로


image = cv2.imread('edit_test/temp.png')
large = cv2.resize(image, (0, 0), fx=2, fy=2, interpolation=cv2.INTER_CUBIC)
rgb = cv2.pyrDown(large)
small = cv2.cvtColor(rgb, cv2.COLOR_BGR2GRAY)
kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3, 3))
grad = cv2.morphologyEx(small, cv2.MORPH_GRADIENT, kernel)
_, bw = cv2.threshold(grad, 0.0, 255.0, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (9, 1))
connected = cv2.morphologyEx(bw, cv2.MORPH_CLOSE, kernel)
# using RETR_EXTERNAL instead of RETR_CCOMP
_, contours, hierarchy = cv2.findContours(connected.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
mask = np.zeros(bw.shape, dtype=np.uint8)

for idx in range(len(contours)):
    x, y, w, h = cv2.boundingRect(contours[idx])
    mask[y:y + h, x:x + w] = 0
    cv2.drawContours(mask, contours, idx, (255, 255, 255), -1)
    r = float(cv2.countNonZero(mask[y:y + h, x:x + w])) / (w * h)
    if r > 0.45 and w > 8 and h > 8:
        # 픽셀 값 추출
        r, g, b = large[x, y]
        r = int(r)
        g = int(g)
        b = int(b)
        # 글자 영역 주변 색으로 칠하기
        cv2.rectangle(rgb, (x, y), (x + w - 1, y + h - 1), (r, g, b), -1)
# show image with contours rect
# 문자 위치 선택 여부
flag = False
cv2.namedWindow("image")
cv2.setMouseCallback("image", MouseLeftClick)

clone = rgb.copy()

while True:
    cv2.imshow("image", rgb)
    key = cv2.waitKey(0)

    if key == ord('q'):  # 프로그램 종료
        break

# 모든 window를 종료합니다.
cv2.destroyAllWindows()
