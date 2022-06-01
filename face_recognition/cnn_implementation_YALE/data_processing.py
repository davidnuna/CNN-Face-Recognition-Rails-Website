import keras
import numpy as np
import cv2
import matplotlib.pyplot as plt
import os
import sys

def preprocess_images(path):
    for img in os.listdir(path):
        print(img)
        image = cv2.imread(path + img, cv2.IMREAD_GRAYSCALE)

        name = str(os.listdir(path).index(img)) + '.pgm'
        image  = cv2.resize(image, (168, 192))
        cv2.imwrite(name, image)

def preprocess_single_image(image_path):
    print(image_path)
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

    name = image_path + '.pgm'
    image = cv2.resize(image, (168, 192))
    cv2.imwrite(name, image)

if __name__ == '__main__':
    if len(sys.argv) == 2:
        preprocess_single_image(sys.argv[1])
        exit()
    path = './new/'
    path_dstore = path + '.DS_Store'
    if os.path.exists(path_dstore):
        os.remove(path_dstore)

    preprocess_images(path)