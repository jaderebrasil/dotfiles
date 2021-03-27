#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Faltam parametros."
	exit 1
fi

if [ "$#" -ge 2 ]; then
	ffmpeg -i "$1" "$2"
else
	file=$1
	ffmpeg -i "$1" "${file/.mp4/.srt}"
fi
