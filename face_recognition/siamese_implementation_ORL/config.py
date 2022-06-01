import os

IMG_SHAPE = (32, 32, 1)

BATCH_SIZE = 20
EPOCHS = 150

BASE_OUTPUT = "output"
MODEL_PATH = os.path.sep.join([BASE_OUTPUT, "model.h5"])
PLOT_PATH = os.path.sep.join([BASE_OUTPUT, "plot.png"])