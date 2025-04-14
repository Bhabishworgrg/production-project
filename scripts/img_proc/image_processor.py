import cv2
import numpy as np
import sys 
from skimage import filters
from scipy.ndimage import binary_fill_holes
from os import path 


if len(sys.argv) != 3:
    print(f'{len(sys.argv)} arguments provided. Expected 2 arguments.')
    sys.exit(1)

output_dir = f'{path.dirname(__file__)}/../../assets'
if not path.exists(output_dir):
    print(f'Output directory {output_dir} does not exist.')
    sys.exit(1)

output = f'{output_dir}/{sys.argv[2]}.png'

image = cv2.imread(sys.argv[1]);
if image is None:
    print(f'Could not read image {sys.argv[1]}')
    sys.exit(1)

print(f'Processing image {sys.argv[1]}...')

# Gray scale conversion
image_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Sobel edge detection
sobel = filters.sobel(image_gray)

threshold = filters.threshold_otsu(sobel)
fudge_factor = 0.1
edge_mask = sobel > (threshold * fudge_factor)
edge_mask = (edge_mask * 255).astype(np.uint8)

# Dilate the edges
kernel_v = cv2.getStructuringElement(cv2.MORPH_RECT, (1, 3))
kernel_h = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 1))
dilated = cv2.dilate(edge_mask, kernel_v)
dilated = cv2.dilate(dilated, kernel_h)

# Fill internal holes
filled = binary_fill_holes(dilated > 0).astype(np.uint8) * 255

# Add alpha channel
image_rgba = cv2.cvtColor(image, cv2.COLOR_BGR2RGBA)
image_rgba[:, :, 3] = filled 

if not cv2.imwrite(output, image_rgba):
    print(f'Failed to write image to {output}')
    sys.exit(1)
print(f'Image saved to {output}')
