import cv2
import numpy as np
import sys 
from skimage import filters
from scipy.ndimage import binary_fill_holes
 
output = f'../../assets/{sys.argv[2]}.png'
image = cv2.imread(sys.argv[1]);

# Gray scale conversion
image_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
cv2.imshow('gray image', image_gray)
cv2.waitKey(0)

# Sobel edge detection
sobel = filters.sobel(image_gray)
threshold = filters.threshold_otsu(sobel)
fudge_factor = 0.1
edge_mask = sobel > (threshold * fudge_factor)
edge_mask = (edge_mask * 255).astype(np.uint8)
cv2.imshow('sobel image', edge_mask)
cv2.waitKey(0)

# Dilate the edges
kernel_v = cv2.getStructuringElement(cv2.MORPH_RECT, (1, 3))
kernel_h = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 1))
dilated = cv2.dilate(edge_mask, kernel_v)
dilated = cv2.dilate(dilated, kernel_h)
cv2.imshow('sobel image dilated', dilated)
cv2.waitKey(0)

# Fill internal holes
filled = binary_fill_holes(dilated > 0).astype(np.uint8) * 255
cv2.imshow('sobel image filled', filled)
cv2.waitKey(0)

# Add alpha channel
image_rgba = cv2.cvtColor(image, cv2.COLOR_BGR2RGBA)
image_rgba[:, :, 3] = filled 

cv2.imwrite(output, image_rgba)
