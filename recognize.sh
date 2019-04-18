#!/bin/bash

if [ "${1}" == "--help" ]; then
  echo ""
  echo "Usage: $0 [filename from data/images folder]"
  echo "Recognizes the person in the specified picture. If no filename is specified, then recognizes the faces in all pictures in the data/images folder." 
  echo ""
  exit 0
fi

./run.sh face_recognition /wd/data/known_people /wd/data/images/$1 --show-distance True --tolerance 0.586 | grep -v None


