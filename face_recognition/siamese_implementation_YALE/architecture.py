from tensorflow.keras.models import Model
from tensorflow.keras.layers import Input
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import Dropout
from tensorflow.keras.layers import GlobalAveragePooling2D
from tensorflow.keras.layers import MaxPooling2D
from keras.utils.vis_utils import plot_model

def build_siamese_model(inputShape, embeddingDim=48):
	input_layer = Input(inputShape)

	convolution_1 = Conv2D(64, (2, 2), padding="same", activation="relu")(input_layer)
	max_pooling_1 = MaxPooling2D(pool_size=(2, 2))(convolution_1)
	dropout_1 = Dropout(0.3)(max_pooling_1)
	convolution_2 = Conv2D(64, (2, 2), padding="same", activation="relu")(dropout_1)
	max_pooling_1 = MaxPooling2D(pool_size=2)(convolution_2)
	dropout_2 = Dropout(0.3)(max_pooling_1)

	pooledOutput = GlobalAveragePooling2D()(dropout_2)
	output_layer = Dense(embeddingDim)(pooledOutput)
	model = Model(input_layer, output_layer)
	plot_model(model, to_file='model_plot_1.png', show_shapes=True, show_layer_names=True)

	return model