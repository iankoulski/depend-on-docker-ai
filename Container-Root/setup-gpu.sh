#!/bin/sh

if [ -d /etc/apt ]; then
        [ -n "$http_proxy" ] && echo "Acquire::http::proxy \"${http_proxy}\";" > /etc/apt/apt.conf; \
        [ -n "$https_proxy" ] && echo "Acquire::https::proxy \"${https_proxy}\";" >> /etc/apt/apt.conf; \
        [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf
fi

apt update -y; apt install -y \
git \
cmake \
libsm6 \
libxext6 \
libxrender-dev \
python3 \
python3-pip

pip3 install scikit-build

apt-get install -y software-properties-common

add-apt-repository ppa:ubuntu-toolchain-r/test

apt update -y; apt install -y gcc-6 g++-6 libopenblas-dev liblapack-dev

update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 50
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 50

#Install dlib 

git clone -b 'v19.16' --single-branch https://github.com/davisking/dlib.git
mkdir -p /dlib/build

cmake -H/dlib -B/dlib/build -DDLIB_USE_CUDA=1 -DUSE_AVX_INSTRUCTIONS=1
cmake --build /dlib/build

cd /dlib; python3 /dlib/setup.py install

# Install the face recognition package
#pip3 install face_recognition

cd ~ && \
    mkdir -p face_recognition && \
    git clone https://github.com/ageitgey/face_recognition.git face_recognition/ && \
    cd face_recognition && \
    pip3 install -r requirements.txt && \
    python3 setup.py install

