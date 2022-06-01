from tensorflow.keras.models import load_model
from imutils.paths import list_images
import matplotlib.pyplot as plt
import numpy as np
import argparse
import cv2
import os
import config
import utils

ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True, help="path to image")
args = vars(ap.parse_args())

print("[INFO] loading image...")
user_image = cv2.imread(args["image"], 0) # Converts to gray scale? To check
user_image = cv2.resize(user_image, (32, 32))
user_image = np.expand_dims(user_image, axis=-1)

print("[INFO] loading siamese model...")
model = load_model(config.MODEL_PATH)

print("[INFO] loop over each image in dataset...")
current_dir = os.getcwd().split('/')[-1]
path = './face_recognition/siamese_implementation/ORL_database/orl_faces/' if current_dir == 'face_recognition_app' else './ORL_database/orl_faces/'

class_score = {}
for dir in os.listdir(path):
    class_score[dir] = 0
    for index, image in enumerate(os.listdir(path + dir)):
        current_image = cv2.imread(path + dir + '/' + image, 0)
        current_image = cv2.resize(current_image, (32, 32))

        current_image_copy = current_image.copy()
        user_image_copy = user_image.copy()

        current_image_copy = np.expand_dims(current_image_copy, axis=-1)
        current_image_copy = np.expand_dims(current_image_copy, axis=0) / 255.0
        user_image_copy = np.expand_dims(user_image_copy, axis=0) / 255.0
        
        [prediction] = model.predict([user_image_copy, current_image_copy])
        similarity = prediction[0]
        class_score[dir] += similarity

        if dir != 'david':
            continue

        fig = plt.figure("Pair #{}".format(index + 1), figsize=(4, 2))
        plt.suptitle("Similarity: {:.2f}".format(similarity))

        ax = fig.add_subplot(1, 2, 1)
        plt.imshow(user_image, cmap=plt.cm.gray)
        plt.axis("off")

        ax = fig.add_subplot(1, 2, 2)
        plt.imshow(current_image, cmap=plt.cm.gray)
        plt.axis("off")

        plt.show()

print(class_score['david'])
highest3 = sorted(class_score, key=class_score.get, reverse=True)[:3]
for predicted_class in highest3:
    print(predicted_class, f'{class_score[predicted_class]:.2f}')