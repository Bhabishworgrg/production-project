from rembg import remove
from cv2 import imread, imwrite
from sys import argv

input_path = argv[1]
output_path = '../../assets/player.png'

input = imread(input_path)
output = remove(input)
imwrite(output_path, output)
