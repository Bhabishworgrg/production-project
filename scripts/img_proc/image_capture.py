import cv2 as cv
from os import sys


video = cv.VideoCapture(0)

success = False

while True:
    success, frame = video.read()
    
    if not success or (cv.waitKey(1) & 0xFF == 13):
        break
  
    displayed_frame = frame.copy()
    cv.putText(displayed_frame, f"Press enter to click photo.", (10, 50), cv.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
    cv.imshow("Video Feed", displayed_frame)

    if cv.waitKey(1) & 0xFF == 27:
        sys.exit(0)

video.release()
cv.destroyAllWindows()

if success:
    while True:
        displayed_frame = frame.copy()
        cv.putText(displayed_frame, f"Press enter to confirm.", (10, 50), cv.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
        cv.imshow("Captured Image", displayed_frame)
        
        if cv.waitKey(1) & 0xFF == 27:
            sys.exit(0)

        if cv.waitKey(1) & 0xFF == 13:
            break
    
    cv.imwrite("captured_image.png", frame)

video.release()
cv.destroyAllWindows()
