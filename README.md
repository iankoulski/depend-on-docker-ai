# Depend on Docker for AI - Face Recognition

This repository is an example of a [Depend on Docker](https://github.com/bhgedigital/depend-on-docker) project used to build, ship and run an AI application for face recognition.

Credit for the application code goes to [Adam Geitgey](https://github.com/ageitgey). This project is based on the the following GitHub repository: [https://github.com/ageitgey/face_recognition](https://github.com/ageitgey/face_recognition). The face recognition model from this repo is containerized as a Depend on Docker project and published to [this repository](https://github.com/iankoulski/depend-on-docker-ai). An automated build picks up changes from [here](https://github.com/iankoulski/depend-on-docker-ai) and pushes the container images to [DockerHub](https://hub.docker.com/r/iankoulski/face-recognition).

## Configure

As with any [Depend on Docker](https://github.com/bhgedigital/depend-on-docker) project, all configuration settings are centralized in the .env file. Modifications of settings in this file take effect for all new commands. If a container is already running, in order for new settings to take effect, that container needs to be stopped and restarted. 

## Build

You can build this project by running the ./build.sh script. By default this script builds a CPU and a GPU image containing the face_recognition CLI. To build only one of these images pass the respective argument as shown below.

    ./build.sh cpu

or 

    ./build.sh gpu

## Ship

You can ship or obtain the container image from a registry after reviewing the REGISTRY and IMAGE settings in the .env file by using the push.sh and pull.sh scripts.

## Run

This container uses a face_recognition CLI to match pictures of unknown people's faces to known pictures of people's faces. 

### Clone the repository (Optional)

Cloning the repository is optional, it provides convenience scripts and a sample folder structure. If you wish to run the container directly, please refer to the "[Using docker](#UsingDocker)" subsection below.

    git clone https://github.com/iankoulski/depend-on-docker-ai.git

### Set processor type

This project can run either on CPU or GPU using the corresponding container image. By default the run.sh script uses the CPU continer. To control where to run the workload, please define environment variable PROCESSOR_TYPE before executing run.sh.

    export PROCESSOR_TYPE=CPU   -   Runs face recognition on CPU (default)

or

    export PROCESSOR_TYPE=GPU   -   Runs face recognition on GPU

To run on GPU using the scripts in this project, it is assumed that a GPU is available on the machine and NVIDIA CUDA driver version 10.0 or greater is installed.

### Load data or use the sample images

The data folder in this project contains two subfolders: images and known_people. Please store pictures of unknown faces in the images folder and provide one example picture of each person's face that you would like the model to be able to recognize in the known_people folder. Name each file in the known_people folder with the name of the person who is in the picture. Each picture in this folder should contain only one face.

Directory structure:

    project_folder
          ┃
          ┗━━ data
                ┃
                ┣━━ images
                ┃      ┃
                ┃      ┗━━ TestImage.jpg
                ┃
                ┗━━ known_people
                       ┃
                       ┠━━ Alex.jpg
                       ┃
                       ┗━━ Fabio.jpg


You may copy your own files in this folder structure, or use the provided sample images.

The following options are available for running face_recognition:

### Use recognize.sh


    ./recognize.sh [FileName]


Performs face recognition on the specified FileName located in the data/images folder. If no FileName is specified, then all images in the folder are processed.

Embedded example:

<p align="center"><img alt="Face Recognition Example" src="https://github.com/iankoulski/depend-on-docker-ai/raw/master/docs/FaceRecognitionAnimationSD.gif" width="90%" align="center"/></p>

This example uses the embedded images Alex.jpg and Fabio.jpg to learn facial features and then recognizes faces in TestImage.jpg. Note that the known images have significant differences with the test image which could make a face recognition task challenging. Most of Alex's sample is taken by a prominent background, while Fabio is facing forward in the sample and sideways in the test image. Regardless, the face recognition application is able to identify the people correctly with good distance metrics: 0.48 for Alex and 0.38 for Fabio. Distance metrics are numbers between 0 and 1. A face is recognized with higher certainty when the distance metric is closer to 0.

### Use run.sh 

    ./run.sh face_recognition /wd/data/known_people /wd/data/images/TestImage.jpg [--show-distance True] [--tolerance 0.6]

Performs face recognition and gives you control of which folders to use for known and unknown people. To change the volume mount, modify file .env

### <a name="UsingDocker"></a>Use Docker

Running on CPU

    docker container run -v $(pwd):/wd --rm -it iankoulski/face-recognition face_recognition /wd/data/known_people /wd/data/images/TestImage.jpg --show-distance True

Running on GPU with CUDA10.x

    docker container run --runtime=nvidia -e LC_ALL=C.UTF-8 -e LANG=C.UTF-8 -v $(pwd):/wd --rm -it iankoulski/face-recognition face_recognition /wd/data/known_people /wd/data/images/TestImage.jpg --show-distance True

Running on GPU with CUDA9.x

    nvidia-docker run -e LC_ALL=C.UTF-8 -e LANG=C.UTF-8 -v $(pwd):/wd --rm -it iankoulski/face-recognition face_recognition /wd/data/known_people /wd/data/images/TestImage.jpg --show-distance True

Runs the face-recognition container without relying on any of the template scripts.

## Test

    ./test.sh

Runs an internal test against data that is stored within the container to ensure that the face_recognition functionality works as expected.

# References

- [Depend on Docker](https://github.com/bhgedigital/depend-on-docker)
- [Depend on Docker for AI - Dockercon 2019](https://dockercon19.smarteventscloud.com/connect/sessionDetail.ww?SESSION_ID=290742)
- [Face Recognition Container Image on DockerHub](https://hub.docker.com/r/iankoulski/face-recognition)
- [Romario Project](https://github.com/bhgedigital/romario)
- [Face Recognition Project](https://github.com/ageitgey/face_recognition)

