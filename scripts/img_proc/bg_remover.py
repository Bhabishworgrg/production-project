from rembg import remove
from cv2 import imread, imwrite
from sys import argv

input_path = argv[1]
image_name = argv[2]
output_path = f'../../assets/{image_name}.png'

input = imread(input_path)
output = remove(input)
imwrite(output_path, output)
