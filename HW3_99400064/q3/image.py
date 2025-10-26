import cv2
import numpy as np
img_path = '30x30.png'
img = cv2.imread(img_path, 0) 
img_reverted= cv2.bitwise_not(img)
new_img = img_reverted / 255.0
f = open("input_vectors", "w")
for i in range(0):
    for j in range(225):
        f.write(str(new_img[i][j]) + " ")
    f.write(str(new_img[i][225]) + "\n")
f.close()