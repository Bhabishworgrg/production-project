import cv2
import numpy as np
import sys 
from skimage import filters
from scipy.ndimage import binary_fill_holes
from os import path


def _remove_background(image: np.ndarray, algorithm: str) -> np.ndarray:
    if algorithm == 'color_threshold':
        image_rgba = cv2.cvtColor(image, cv2.COLOR_BGR2RGBA)
    
        lower_white = np.array([200, 200, 200, 0])
        upper_white = np.array([255, 255, 255, 255])

        mask = cv2.inRange(image_rgba, lower_white, upper_white)

        image_rgba[:, :, 3] = np.where(mask == 255, 0, image_rgba[:, :, 3])
        return image_rgba
    
    if algorithm == 'edge_detection':
        image_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        image_rgba = cv2.cvtColor(image, cv2.COLOR_BGR2RGBA)

        sobel = filters.sobel(image_gray)
        threshold = filters.threshold_otsu(sobel)
        fudge_factor = 0.3 
        
        edge_mask = sobel > (threshold * fudge_factor)
        edge_mask = (edge_mask * 255).astype(np.uint8)

        kernel_v = cv2.getStructuringElement(cv2.MORPH_RECT, (1, 3))
        kernel_h = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 1))
        dilated = cv2.dilate(edge_mask, kernel_v)
        dilated = cv2.dilate(dilated, kernel_h)

        filled = binary_fill_holes(dilated > 0).astype(np.uint8) * 255

        image_rgba[:, :, 3] = filled 
        return image_rgba

    if algorithm == 'edge_detection_no_fill':
        image_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        image_rgba = cv2.cvtColor(image, cv2.COLOR_BGR2RGBA)
         
        sobel = filters.sobel(image_gray)
        threshold = filters.threshold_otsu(sobel)
        fudge_factor = 0.3
        
        edge_mask = sobel > (threshold * fudge_factor)
        edge_mask = (edge_mask * 255).astype(np.uint8)
        
        kernel_v = cv2.getStructuringElement(cv2.MORPH_RECT, (1, 3))
        kernel_h = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 1))
        dilated = cv2.dilate(edge_mask, kernel_v)
        dilated = cv2.dilate(dilated, kernel_h)
         
        image_rgba[:, :, 3] = dilated 
        return image_rgba
    
    print(f'Unknown algorithm {algorithm}. Supported algorithms: color_threshold, edge_detection')
    return None


def _main() -> None:
    if len(sys.argv) != 4:
        print(f'{len(sys.argv)} arguments provided. Expected 3 arguments.')
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
    background_removed_image = _remove_background(image, sys.argv[3])

    if not cv2.imwrite(output, background_removed_image):
        print(f'Failed to write image to {output}')
        sys.exit(1)
    print(f'Image saved to {output}')


if __name__ == '__main__':
    _main()
