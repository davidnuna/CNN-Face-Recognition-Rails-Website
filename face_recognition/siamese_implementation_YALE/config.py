import os

IMG_SHAPE = (64, 64, 1)

BATCH_SIZE = 16
EPOCHS = 200

BASE_OUTPUT = "output"
MODEL_PATH = os.path.sep.join([BASE_OUTPUT, "model.h5"])
PLOT_PATH = os.path.sep.join([BASE_OUTPUT, "plot.png"])