FROM ubuntu:16.04

RUN  apt-get update
RUN  apt-get upgrade -y

# Install python packages 
RUN  apt-get install -y python3

# Install compile tools
RUN  apt-get update
RUN  apt-get install -y python3-dev build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
RUN apt-get install -qqy x11-apps

# Install dependencies tools 
RUN apt-get install -y wget vim
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
RUN python3 /tmp/get-pip.py
RUN pip install --upgrade pip

# Install core packages 
RUN  pip install -U numpy
RUN  pip install -U matplotlib
RUN  pip install -U notebook 
RUN  pip install --upgrade jupyter
RUN  pip install -U pandas

RUN  apt-get install -y ffmpeg
RUN  pip install -U moviepy

# Install tensorFlow and keras
RUN pip install -U tensorflow
RUN pip install -U keras

# Install tensorflow models object detection
RUN git clone https://github.com/tensorflow/models /usr/local/lib/python3.5/dist-packages/tensorflow/models
RUN apt-get install -y python-pil python-lxml python-tk
RUN wget -P /usr/local/src/ https://github.com/google/protobuf/releases/download/v3.5.1/protobuf-python-3.5.1.tar.gz
RUN cd /usr/local/src/ && tar xvf protobuf-python-3.5.1.tar.gz && rm protobuf-python-3.5.1.tar.gz 
RUN cd /usr/local/src/protobuf-3.5.1/ && ./configure && make && make install && ldconfig

#add dataframe display widget
RUN pip install -U autovizwidget && jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Install OpenCV
RUN apt-get install -y unzip
RUN wget -P /usr/local/src/ https://github.com/opencv/opencv/archive/3.4.1.zip
RUN cd /usr/local/src/ && unzip 3.4.1.zip && rm 3.4.1.zip
RUN cd /usr/local/src/opencv-3.4.1/ && mkdir build
RUN cd /usr/local/src/opencv-3.4.1/build && cmake -D CMAKE_INSTALL_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local/ .. && make -j4 && make install

#Setting up working directory 
RUN mkdir /lab
WORKDIR /lab
#ADD . /lab/

#Minimize image size 
RUN (apt-get autoremove -y; \
     apt-get autoclean -y)

#Set TF object detection available
ENV PYTHONPATH "$PYTHONPATH:/usr/local/lib/python3.5/dist-packages/tensorflow/models/research:/usr/local/lib/python3.5/dist-packages/tensorflow/models/research/slim"
RUN cd /usr/local/lib/python3.5/dist-packages/tensorflow/models/research && protoc object_detection/protos/*.proto --python_out=.

CMD bash exec.sh