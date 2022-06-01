import keras
import numpy as np
import cv2
import matplotlib.pyplot as plt
import os
import pickle
import matplotlib.pyplot as plt

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
    path = './face_recognition/cnn_implementation_YALE/YALE_database/yale_faces_altered/' if current_dir == 'face_recognition_app' else './YALE_database/yale_faces_altered/'
    path_dstore = path + '.DS_Store'
    if os.path.exists(path_dstore):
        print('DS_STORE in root file removed')
        os.remove(path_dstore)

    # 1-hot encoding
    a = np.array([i for i in range(39)])
    classes = np.zeros((a.size, a.max() + 1))
    classes[np.arange(a.size), a] = 1

    train_array, test_array = [], []
    counter = 0
    for dir in os.listdir(path):
        for img in sorted(os.listdir(path + dir)):
            if img == '.DS_Store':
                os.remove(path + dir + '/' + img)

        for idx, img in enumerate(sorted(os.listdir(path + dir))):
            image = cv2.imread(path + dir + '/' + img, 0)
            image = cv2.resize(image, (64, 64))
            image = image[:, :, np.newaxis]
            if (idx+1) % 8 == 0:
                test_array.append((image, classes[os.listdir(path).index(dir)]))
            else:
                train_array.append((image, classes[os.listdir(path).index(dir)]))

    print(len(test_array))
    print(len(train_array))

    model = create_model(image_shape = (64, 64, 1))

    train_images, train_labels = np.array([t[0] for t in train_array]), np.array([t[1] for t in train_array])
    test_images, test_labels = np.array([t[0] for t in test_array]), np.array([t[1] for t in test_array])

    history = model.fit(train_images, train_labels,
                        batch_size=64,
                        epochs=15,
                        verbose=2,
                        validation_data=(test_images, test_labels))

    model.save("model.h5")
    test_scores = model.evaluate(test_images,  test_labels, verbose=0)
    
    print('Test loss', f'{test_scores[0]:.6f}')
    print('Test accuracy', f'{test_scores[1]:.6f}')

    plotPath = os.path.sep.join(["output", "plot.png"])
    plt.style.use("ggplot")
    plt.figure()
    plt.plot(history.history["loss"], label="train_loss")
    plt.plot(history.history["val_loss"], label="val_loss")
    plt.plot(history.history["accuracy"], label="train_acc")
    plt.plot(history.history["val_accuracy"], label="val_acc")
    plt.title("Training Loss and Accuracy")
    plt.xlabel("Epoch #")
    plt.ylabel("Loss/Accuracy")
    plt.legend(loc="best")
    plt.savefig(plotPath)

if __name__ == '__main__':
    train_model()