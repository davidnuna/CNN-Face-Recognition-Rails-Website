import keras
import numpy as np
import cv2
import matplotlib.pyplot as plt
import os
import pickle

from keras.models import Sequential
from tensorflow.keras.optimizers import RMSprop
from keras.preprocessing.image import ImageDataGenerator, img_to_array
from keras import backend as K
from keras import regularizers
from random import randint
from sklearn.model_selection import train_test_split
from sklearn.metrics.pairwise import cosine_similarity
from architecture import *

def train_model():
    current_dir = os.getcwd().split('/')[-1]
    path = './cnn_logic/att_faces/orl_faces/' if current_dir == 'face_recognition' else './att_faces/orl_faces/'
    path_dstore = path + '.DS_Store'
    if os.path.exists(path_dstore):
        os.remove(path_dstore)

    # 1-hot encoding
    a = np.array([i for i in range(41)])
    classes = np.zeros((a.size, a.max() + 1))
    classes[np.arange(a.size), a] = 1

    train_array = []
    test_array = []

    # let random index and 9th(enumerate begins at 0 so index 8 represents image 9) pgm for test
    for dir in os.listdir(path):
        i1, i2 = 8, randint(0, 7)
        for idx, img in enumerate(sorted(os.listdir(path + dir))):
            image = cv2.imread(path + dir + '/' + img, 0)
            image = cv2.resize(image, (32, 32))
            image = image[:, :, np.newaxis]
            if idx == i1 or idx == i2:
                test_array.append((image, classes[os.listdir(path).index(dir)]))
                continue
            train_array.append((image, classes[os.listdir(path).index(dir)]))

    print(len(test_array))
    print(len(train_array))

    model = create_model(image_shape = (32, 32, 1))

    train_images, train_labels = np.array([t[0] for t in train_array]), np.array([t[1] for t in train_array])
    test_images, test_labels = np.array([t[0] for t in test_array]), np.array([t[1] for t in test_array])

    history = model.fit(train_images, train_labels,
                        batch_size=20,
                        epochs=12,
                        verbose=2,
                        validation_data=(test_images, test_labels))

    model.save("model.h5")

if __name__ == '__main__':
    train_model()