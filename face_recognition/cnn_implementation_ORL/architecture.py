import keras
import numpy as np
import os
import pickle

from tensorflow.keras import layers, models, regularizers

def create_model(image_shape):
    input_layer = layers.Input(shape = image_shape)
    convolution_1 = layers.Conv2D(16, (3,3), kernel_regularizer = regularizers.l2(0.), activity_regularizer = regularizers.l2(0.), activation = "relu")(input_layer)
    max_pooling_1 = layers.MaxPooling2D((2,2))(convolution_1)
    batch_normalization_1 = layers.BatchNormalization()(max_pooling_1)
    dropout_1 = layers.Dropout(0.25)(batch_normalization_1)
    convolution_2 = layers.Conv2D(16, (3,3), kernel_regularizer = regularizers.l2(0.), activity_regularizer = regularizers.l2(0.), activation = "relu")(dropout_1)
    max_pooling_2 = layers.MaxPooling2D((2,2))(convolution_2)
    batch_normalization_2 = layers.BatchNormalization()(max_pooling_2)
    dropout_2 = layers.Dropout(0.25)(batch_normalization_2)
    flatten_1 = layers.Flatten()(dropout_2)
    dense_1 = layers.Dense(3000, activation = 'relu', kernel_regularizer = regularizers.l2(0.), activity_regularizer = regularizers.l2(0.))(flatten_1)
    dropout_3 = layers.Dropout(0.25)(dense_1)
    output_layer = layers.Dense(41, activation = 'softmax')(dropout_3)

    model = models.Model(inputs = input_layer, outputs = output_layer)
    model.compile(optimizer = 'adam', loss = 'categorical_crossentropy', metrics = ['accuracy'])
    model.summary()

    return model

def load_model_from_file():
	current_dir = os.getcwd().split('/')[-1]
	path = './cnn_logic/model.h5' if current_dir == 'face_recognition' else './model.h5'
	model = models.load_model(path)
	return model

def compute_classes():
    current_dir = os.getcwd().split('/')[-1]
    path = './cnn_logic/att_faces/orl_faces/' if current_dir == 'face_recognition' else './att_faces/orl_faces/'
    a = np.array([i for i in range(41)])
    classes = np.zeros((a.size, a.max() + 1))
    classes[np.arange(a.size), a] = 1
    dir_array = []

    path_dstore = path + '.DS_Store'
    if os.path.exists(path_dstore):
        os.remove(path_dstore)

    counter = 0
    for dir in os.listdir(path):
        dir_array.append(dir)

    return classes, dir_array