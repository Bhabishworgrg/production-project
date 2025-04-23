import cv2 as cv
from os import system

video = cv.VideoCapture(0)

success = False

while not (cv.waitKey(1) & 0xFF == 13):
    success, frame = video.read()
    
    if not success:
        break
  
    displayed_frame = frame.copy()
    cv.putText(displayed_frame, f"Press enter to click photo.", (10, 50), cv.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
    cv.imshow("Video Feed", displayed_frame)

video.release()
cv.destroyAllWindows()

if success:
    while not (cv.waitKey(1) & 0xFF == 13):
        displayed_frame = frame.copy()
        cv.putText(displayed_frame, f"Press enter to confirm.", (10, 50), cv.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
        cv.imshow("Captured Image", displayed_frame)
    cv.imwrite("captured_image.png", frame)

