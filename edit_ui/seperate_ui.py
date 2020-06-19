import cv2
import numpy as np
import ui
from mrcnn import utils
from mrcnn import model as modellib
import os
import json
import pandas as pd


class InferenceConfigtrained(ui.CustomConfig):
    GPU_COUNT = 1
    IMAGES_PER_GPU = 1
    DETECTION_MIN_CONFIDENCE = 0.9  # Skip detections with < 90 % confidence


def load_weights():
    global class_names, weights_path, model
    config = InferenceConfigtrained()
    config.display()
    model = modellib.MaskRCNN(
        mode="inference", model_dir=LOGS_FOLDER, config=config
    )
    weights_path = TRAINED_MASKRCNN_WEIGHTS
    model.load_weights(weights_path, by_name=True)
    class_names = ['BG', 'UI']


def random_colors(N):
    np.random.seed(1)
    colors = [tuple(255 * np.random.rand(3)) for _ in range(N)]
    return colors


def image_trim(img, x1, y1, x2, y2):
    w = x2 - x1
    h = y2 - y1
    img_trim = img[y1:y1 + h, x1:x1 + w]
    return img_trim


def apply_mask(image, mask, color, alpha=0.5):
    """apply mask to image"""
    for n, c in enumerate(color):
        image[:, :, n] = np.where(
            mask == 1,
            image[:, :, n] * (1 - alpha) + alpha * c,
            image[:, :, n]
        )
    return image


def display_instances(image, boxes, masks, ids, names, scores):
    """
        take the image and results and apply the mask, box, and label
    """
    n_instances = boxes.shape[0]

    if not n_instances:
        print('NO INSTANCES TO DISPLAY')
    else:
        assert boxes.shape[0] == masks.shape[-1] == ids.shape[0]

    cnt = 0
    origin = image.copy()
    for i in range(n_instances):
        if not np.any(boxes[i]):
            continue
        y1, x1, y2, x2 = boxes[i]
        trim_img = image_trim(origin, x1, y1, x2, y2)
        cnt += 1
        cv2.imwrite(RES_DIR + "/" + user_image.split(".")[0] + "/ui" + str(cnt) + "_" + user_image, trim_img)

        label = names[ids[i]]
        color = class_dict[label]
        #score = scores[i] if scores is not None else None
        #caption = '{}{:.2f}'.format(label, score) if score else label
        mask = masks[:, :, i]
        image = apply_mask(image, mask, color)
        image = cv2.rectangle(image, (x1, y1), (x2, y2), color, 2)
        #image = cv2.putText(image, caption, (x1, y1), cv2.FONT_HERSHEY_COMPLEX, 0.5, color, 2)

    return image, n_instances


LOGS_FOLDER = "model"
TRAINED_MASKRCNN_WEIGHTS = "model/mask_rcnn_ui_0009.h5"
CLASSES = ['UI']
IMG_DIR = "input"  ##사진 넣는 곳.
RES_DIR = "output"  ##결과물 넣는 곳.
user_image = "64.jpg"  ##분리하고 싶은 이미지

def main(TRAINED_MASKRCNN_WEIGHTS_, user_image_):
    global colors, class_dict
    load_weights()
    colors = random_colors(len(class_names))
    class_dict = {name: color for name, color in zip(class_names, colors)}

    global TRAINED_MASKRCNN_WEIGHTS
    TRAINED_MASKRCNN_WEIGHTS = TRAINED_MASKRCNN_WEIGHTS_
    global user_image
    user_image = user_image_
    print("model name(seperate_ui): ", TRAINED_MASKRCNN_WEIGHTS)
    print("image name(seperate_ui)", user_image)

    for filename in os.listdir(IMG_DIR):
        if (filename == user_image):
            # print(filename)
            test_image = cv2.imread(os.path.join(IMG_DIR, filename))
            results = model.detect([test_image], verbose=0)
            r = results[0]
            result, number_of_instances = display_instances(
                test_image, r['rois'], r['masks'], r['class_ids'], class_names, r['scores']
            )
            cv2.imwrite(RES_DIR + "/" + filename, result)
