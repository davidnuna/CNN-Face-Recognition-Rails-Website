from tensorflow.keras.models import Model
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import Input
from tensorflow.keras.layers import Lambda
from tensorflow.keras.datasets import mnist
from random import randint
import numpy as np
import cv2
import os

from architecture import build_siamese_model
import config
import utils

print("[INFO] loading dataset...")
current_dir = os.getcwd().split('/')[-1]
path = './face_recognition/siamese_implementation_YALE/YALE_database/yale_faces_altered/' if current_dir == 'face_recognition_app' else './YALE_database/yale_faces_altered/'
path_dstore = path + '.DS_Store'
if os.path.exists(path_dstore):
    print('DS_STORE in root file removed')
    os.remove(path_dstore)


train_images, train_labels = [], []
test_images, test_labels = [], []

for dir in os.listdir(path):
    for img in sorted(os.listdir(path + dir)):
        if img == '.DS_Store':
            os.remove(path + dir + '/' + img)

    class_index = os.listdir(path).index(dir)
    for idx, img in enumerate(sorted(os.listdir(path + dir))):
        image = cv2.imread(path + dir + '/' + img, 0)
        image = cv2.resize(image, (32, 32))
        image = image[:, :, np.newaxis]
        if (idx+1) % 8 == 0:
            test_images.append(image)
            test_labels.append(class_index)
        else:
            train_images.append(image)
            train_labels.append(class_index)
train_images = np.array(train_images) / 255.0
train_labels = np.array(train_labels)
test_images = np.array(test_images) / 255.0
test_labels = np.array(test_labels)

print(train_images.shape)
print(train_labels.shape)
print(test_images.shape)
print(test_labels.shape)

print("[INFO] preparing positive and negative pairs...")
(pairTrain, labelTrain) = utils.make_pairs(train_images, train_labels)
(pairTest, labelTest) = utils.make_pairs(test_images, test_labels)

print("[INFO] building siamese network...")
imgA = Input(shape=config.IMG_SHAPE)
imgB = Input(shape=config.IMG_SHAPE)
featureExtractor = build_siamese_model(config.IMG_SHAPE)
featsA = featureExtractor(imgA)
featsB = featureExtractor(imgB)

distance = Lambda(utils.euclidean_distance)([featsA, featsB])
outputs = Dense(1, activation="sigmoid")(distance)
model = Model(inputs=[imgA, imgB], outputs=outputs)

#
print("[INFO] compiling model...")
model.compile(loss="binary_crossentropy", optimizer="adam", metrics=["accuracy"])

print("[INFO] training model...")
history = model.fit(
    [pairTrain[:, 0], pairTrain[:, 1]], labelTrain[:],
    validation_data=([pairTest[:, 0], pairTest[:, 1]], labelTest[:]),
    batch_size=config.BATCH_SIZE, 
    epochs=config.EPOCHS)


print("[INFO] saving siamese model...")
model.save(config.MODEL_PATH)

print("[INFO] saving plot for training history...")
utils.plot_training(history, config.PLOT_PATH)