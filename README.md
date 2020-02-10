# Object-detection v1

Apply tensorflow object detection on input video stream. One could use webcam (or any other device) stream or send a video file. It is possible to write Output file with detection boxes.

# To use it:

- Requirements: Linux with docker

- Clone repo in your working directory

- Build docker image:

> docker build -t realtime-objectdetection .

- Configure script (see bellow)

- Launch script:

> bash runDocker.sh

# To configure it:

Configuration is made in exec.sh at python function call:

> python3 my-object-detection.py ...

All possible arguments are:

```
-n (--num-frames): type=int, default=0: # of frames to loop over for FPS test

-d (--display), type=int, default=0: Whether or not frames should be displayed

-f (--fullscreen), type=int, default=0: Enable full screen

-o (--output), type=int, default=0: Whether or not modified videos shall be writen

-on (--output-name), type=str, default="output": Name of the output video file

-I (--input-device), type=int, default=0: Device number input

-i (--input-videos), type=str, default="": Path to videos input, overwrite device input if used

-w (--num-workers), type=int, default=2: Number of workers

-q-size (--queue-size), type=int, default=5: Size of the queue

-l (--logger-debug), type=int, default=0: Print logger debug

```
#### Suggested configuration (exec.sh):

- Webcam stream: default values

> python3 my-object-detection.py -d 1 -o 1

- Video stream: 20 workers, 150 queue size (adapt queue to avoid missing frames)

> python3 my-object-detection.py -d 1 -o 1 -i test.mp4 -w 20 -q-size 150

#### Input/Ouput files

- Inputs file are in inputs/ folder

- Outputs file are in outputs/ folder (.avi)

# Tools versions:

- Ubuntu 16.04
- python 3.5
- tensorflow 1.15.2
- protobuf 3.5.1
- OpenCV 3.4.1

# OS compatibility:

This project is intended to run on Linux. No Windows or IOS compatibility is ensured. (for IOS, it seems to be impossible to use Docker this way. See [https://apple.stackexchange.com/questions/265281/using-webcam-connected-to-macbook-inside-a-docker-container] for more information)

# Remarks for Tensorflow on machines with older CPUs (from Sinan81):

From Tensorflow developers: "Starting with TensorFlow 1.6, binaries use AVX instructions which may not run on older CPUs." Hence, on machines with older CPUS, one might get an SSE4.1 compatibility runtime error as discussed in Issue #14. Hence, Tensorflow pip package v1.5 or earlier needs to be used (which might lead to some other runtime error), or else Tensorflow pip package must be built from source as discussed in [https://www.tensorflow.org/install/source]