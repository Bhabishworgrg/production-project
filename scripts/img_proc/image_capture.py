import cv2 as cv
from os import sys


video = cv.VideoCapture(0)
success = False

while True:
    success, frame = video.read()
    
    if not success:
        break
  
    displayed_frame = frame.copy()
    cv.putText(displayed_frame, f"Press enter to click photo.", (10, 50), cv.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
    cv.imshow("Video Feed", displayed_frame)

    key = cv.waitKey(1) & 0xFF
    if key == 27:
        video.release()
        cv.destroyAllWindows()
        sys.exit(0)
    elif key == 13:
        video.release()
        break


if success:
    while True:
        displayed_frame = frame.copy()
        cv.putText(displayed_frame, f"Press enter to confirm.", (10, 50), cv.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
        cv.imshow("Captured Image", displayed_frame)
       
        key = cv.waitKey(1) & 0xFF
        if key == 27:
            cv.destroyAllWindows()
            sys.exit(0)
        elif key == 13:
            cv.destroyAllWindows()
            break
    
    cv.imwrite(f'assets/{sys.argv[1]}.png', frame)
