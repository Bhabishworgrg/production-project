import cv2
import numpy as np
from rembg import remove
from PIL import Image
from io import BytesIO
from sys import argv
import os


input_path = argv[1]
image_name = argv[2]
output_path = f'../../assets/{image_name}.png'


def remove_white_background(image_path, output_path):
    img = cv2.imread(image_path)
    img_cv = cv2.cvtColor(img, cv2.COLOR_RGBA2BGRA)

    lower_white = np.array([200, 200, 200, 0])
    upper_white = np.array([255, 255, 255, 255])

    mask = cv2.inRange(img_cv, lower_white, upper_white)

    img_cv[:, :, 3] = np.where(mask == 255, 0, img_cv[:, :, 3])

    cv2.imwrite(output_path, img_cv)


def resize_image(image_path, width, height):
    image = cv2.imread(image_path)
    resized_image = cv2.resize(image, (width, height))
    cv2.imwrite(image_path, resized_image)


def main():
    if image_name == 'Platform':
        resize_image(input_path, 1920, 1200)
    remove_white_background(input_path, output_path)


if __name__ == "__main__":
    main()
