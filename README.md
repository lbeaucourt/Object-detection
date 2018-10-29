# Object-detection

Apply tensorflow object detection on input video stream. One could use webcam (or any other device) stream or send a video file. It is possible to write Output put file with detection boxes.

# To use it:

Clone repo in your working directory

Build docker image:

> docker build -t realtime-objectdetection .

Configure script (see bellow)

Launch script:

> bash runDocker.sh

# To configure it:

Configuration is made in exec.sh at python function call:

> python3 my-object-detection.py ...

All possible arguments are:

```
-n (--num-frames): type=int, default=0: # of frames to loop over for FPS test

-d (--display), type=int, default=0: Whether or not frames should be displayed

-o (--output), type=int, default=0: Whether or not modified videos shall be writen

-on (--output-name), type=str, default="output": Name of the output video file

-I (--input-device), type=int, default=0: Device number input

-i (--input-videos), type=str, default="": Path to videos input, overwrite device input if used

-w (--num-workers), type=int, default=2: Number of workers

-q-size (--queue-size), type=int, default=5: Size of the queue

-l (--logger-debug), type=int, default=0: Print logger debug

```
Suggested numbers of workers and queues size:

- Webcam stream: default values
- Video stream: 20 workers, 150 queue size (Maybe little hand tunning could be done)

Inputs file are in inputs/ folder

Outputs file are in outputs/ folder (.avi)
