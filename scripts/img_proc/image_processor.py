import cv2 as cv
import numpy as np
import sys 
from skimage import filters
from scipy.ndimage import binary_fill_holes
from os import path


class ImageProcessor:
    _SUPPORTED_ALGORITHMS = ['color_threshold', 'edge_detection', 'edge_detection_no_fill']


    def __init__(self, input_path: str, output_dir: str, output_name: str, algorithm: str) -> None:
        if algorithm not in self._SUPPORTED_ALGORITHMS:
            raise ValueError(f'Unknown algorithm {algorithm}. Supported algorithms: {self._SUPPORTED_ALGORITHMS}')

        if not path.isfile(input_path):
            raise FileNotFoundError(f'Input file {input_path} does not exist.')

        if not path.exists(output_dir):
            raise FileNotFoundError(f'Output directory {output_dir} does not exist.')
        
        self.input_path = input_path
        self.output_path = f'{output_dir}/{output_name}.png'
        self.algorithm = algorithm

        self.image = cv.imread(self.input_path)
        if self.image is None:
            raise ValueError(f'Could not read image {self.input_path}')


    def _remove_background(self) -> np.ndarray:
        if self.algorithm == 'color_threshold':
            image_rgba = cv.cvtColor(self.image, cv.COLOR_BGR2RGBA)
        
            lower_white = np.array([200, 200, 200, 0])
            upper_white = np.array([255, 255, 255, 255])
            mask = cv.inRange(image_rgba, lower_white, upper_white)

            image_rgba[:, :, 3] = np.where(mask == 255, 0, image_rgba[:, :, 3])
            return image_rgba
       
        image_gray = cv.cvtColor(self.image, cv.COLOR_BGR2GRAY)
        image_rgba = cv.cvtColor(self.image, cv.COLOR_BGR2RGBA)

        sobel = filters.sobel(image_gray)
        threshold = filters.threshold_otsu(sobel)
        fudge_factor = 0.3 
        
        edge_mask = sobel > (threshold * fudge_factor)
        edge_mask = (edge_mask * 255).astype(np.uint8)

        kernel_v = cv.getStructuringElement(cv.MORPH_RECT, (1, 3))
        kernel_h = cv.getStructuringElement(cv.MORPH_RECT, (3, 1))
        dilated = cv.dilate(edge_mask, kernel_v)
        dilated = cv.dilate(dilated, kernel_h)
        
        if self.algorithm == 'edge_detection':
            filled = binary_fill_holes(dilated > 0).astype(np.uint8) * 255
            image_rgba[:, :, 3] = filled 
        else:
            image_rgba[:, :, 3] = dilated 
        
        return image_rgba


    def process_and_save(self) -> None:
        print(f'Processing image {self.input_path} using {self.algorithm} algorithm...')

        bg_removed_image = self._remove_background()
        if not cv.imwrite(self.output_path, bg_removed_image):
            raise ValueError(f'Failed to save image to {self.output_path}')
        
        print(f'Image saved to {self.output_path}')


def main():
    argc = len(sys.argv)
    if argc != 4:
        print(f'{argc} arguments provided. Expected 3 arguments.')
        sys.exit(1)

    output_dir = f'{path.dirname(__file__)}/../../assets'

    try:
        processor = ImageProcessor(
            input_path=sys.argv[1],
            output_dir=output_dir,
            output_name=sys.argv[2],
            algorithm=sys.argv[3]
        )
        processor.process_and_save()
    except Exception as e:
        print(e)
        sys.exit(1)


if __name__ == '__main__':
    main()
