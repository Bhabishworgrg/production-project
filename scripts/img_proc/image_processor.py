import cv2
import numpy as np
import sys 
from skimage import filters
 
input = sys.argv[1]
image = cv2.imread(input);
image_rgba = cv2.cvtColor(image, cv2.COLOR_RGB2RGBA)
image_gray = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)
cv2.imshow('gray image', image_gray)
cv2.waitKey(0)

threshold = filters.threshold_otsu(filters.sobel(image_gray))

fudge_factor = 0.3
image_bw = filters.sobel(image_gray) > (threshold * fudge_factor)
image_bw = np.uint8(image_bw * 255)
cv2.imshow('sobel image', image_bw)
cv2.waitKey(0)

image_rgba[:, :, 3] = image_bw

cv2.imwrite('output.png', image_rgba)
