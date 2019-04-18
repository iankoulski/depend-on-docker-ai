FROM python:3.6-slim-stretch

MAINTAINER Alex Iankoulski <alex_iankoulski@yahoo.com>

ARG http_proxy
ARG https_proxy
ARG no_proxy

ADD Container-Root /

RUN export http_proxy=$http_proxy; export https_proxy=$https_proxy; export no_proxy=$no_proxy; /setup.sh; rm -f /setup.sh

CMD /startup.sh $@

