import cv2 as cv
import sys
from os import path, makedirs


class ImageCapture:
    def __init__(self, output_dir: str, output_name: str) -> None:
        self.video = cv.VideoCapture(0)
        self.success = False
        self.frame = None
        self.output_dir = output_dir
        self.output_name = output_name


    def _show_message(self, window_name: str, message: str) -> None:
        displayed_frame = self.frame.copy()
        cv.putText(displayed_frame, message, (10, 50), cv.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
        cv.imshow(window_name, displayed_frame)


    def _close(self, error: bool = False, exit: bool = False) -> None:
        self.video.release()
        cv.destroyAllWindows()
        
        if error:
            raise RuntimeError('An error occurred during image capture.')
        if exit:
            sys.exit(0)


    def capture_image(self) -> None:
        while True:
            self.success, self.frame = self.video.read()
            if not self.success:
                self._close(error=True)
            
            self._show_message('Video Feed', 'Press enter to click photo.')
            
            key = cv.waitKey(1) & 0xFF
            if key == 27:
                self._close(exit=True)
            elif key == 13:
                self._close()
                break


    def confirm_capture(self) -> None:
        while True:
            self._show_message('Captured Image', 'Press enter to confirm.')
            
            key = cv.waitKey(1) & 0xFF
            if key == 27:
                self._close(exit=True)
            elif key == 13:
                self._close()
                break
   

    def save_image(self) -> None:
        if not path.exists(self.output_dir):
            makedirs(self.output_dir)

        output_path = f'{self.output_dir}/{self.output_name}.png'
        if not cv.imwrite(output_path, self.frame):
            raise ValueError(f'Failed to save image to {output_path}')
        print(f'Image saved to {output_path}')


def main():
    argc = len(sys.argv)
    if argc != 2:
        print(f'{argc} arguments provided. Expected 1 argument.')
        sys.exit(1)

    output_dir = f'{path.dirname(__file__)}/../../assets'

    try:
        image_capture = ImageCapture(
            output_dir=output_dir,
            output_name=sys.argv[1]
        )
        image_capture.capture_image()
        image_capture.confirm_capture()
        image_capture.save_image()
    except Exception as e:
        print(e)
        sys.exit(1)

        
if __name__ == '__main__':
    main()
