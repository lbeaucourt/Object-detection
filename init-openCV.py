from utils.app_utils import *
import numpy as np
import cv2

if __name__ == '__main__':
    # created a *threaded* video stream, allow the camera sensor to warmup,
    # and start the FPS counter
    vs = WebcamVideoStream(src="inputs/test.mp4").start()
    fps = FPS().start()

    while fps._numFrames < 100:
        # Capture frame-by-frame
        ret, frame = vs.read()
        if ret==True:

            # Display the resulting frame
            cv2.imshow('frame', frame)
            fps.update()
        
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
        else:
            break

    # When everything done, release the capture
    fps.stop()
    vs.stop()
    cv2.destroyAllWindows()
    
