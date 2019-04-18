#!/bin/bash

function build_cpu {
  # Build Docker image for CPU
  export PROCESSOR_TYPE=CPU
  source .env
  docker image build ${BUILD_OPTS} -t ${REGISTRY}${IMAGE}${TAG} .
}

function build_gpu {
  # Build Docker image for GPU
  export PROCESSOR_TYPE=GPU
  source .env
  docker image build ${BUILD_OPTS} -t ${REGISTRY}${IMAGE}${TAG} .
}

case "${1}" in
  "CPU" | "cpu")
    build_cpu
    ;;
  "GPU" | "gpu")
    build_gpu
    ;;
  *)
    build_cpu
    build_gpu
    ;;
esac

