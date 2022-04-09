import cv2
import sys

from architecture import *
from sklearn.metrics.pairwise import cosine_similarity

def predict_class(path):
    model = load_model_from_file()
    classes, dir_array = compute_classes()

    #path = './att_faces/orl_faces/david/' + str(9) + '.pgm'
    pic = cv2.imread(path, cv2.IMREAD_UNCHANGED)
    #cv2.imshow("image", pic)
    #cv2.waitKey(0)
    #cv2.destroyAllWindows()
    pic = cv2.resize(pic, (32, 32))
    pic = pic[:, :, np.newaxis]

    [prediction] = model.predict(np.array([pic]))

    cosine_similarities = sorted([(c, cosine_similarity([prediction], [c])) for c in classes], key=lambda t:t[1], reverse=True)

    similarity_sum = 0
    for similarity in cosine_similarities:
        similarity_sum += similarity[1][0][0]
    highest3 = cosine_similarities[:3]

    for a in highest3:
        predicted_class = dir_array[list(a[0]).index(1)]
        probability = (a[1][0][0] / similarity_sum) * 100
        print(predicted_class, f'{probability:.6f}%')

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Wrong number of arguments, should be 2: the name of the program and the path to the image to be recognized")
        exit()
    path = str(sys.argv[1])
    path_dstore = path + '.DS_Store'
    if os.path.exists(path_dstore):
        os.remove(path_dstore)

    predict_class(path)