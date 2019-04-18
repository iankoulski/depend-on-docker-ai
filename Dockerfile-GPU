FROM nvidia/cuda:9.0-cudnn7-devel
#FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04

MAINTAINER Alex Iankoulski <alex_iankoulski@yahoo.com>

ARG http_proxy
ARG https_proxy
ARG no_proxy

ADD Container-Root /

RUN export http_proxy=$http_proxy; export https_proxy=$https_proxy; export no_proxy=$no_proxy; /setup-gpu.sh; rm -f /setup-gpu.sh

CMD /startup.sh

