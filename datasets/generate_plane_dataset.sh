#!/bin/bash
shopt -s expand_aliases
set -e

BLENDER_FILENAME='../scenes/plane.blend'
PYTHON_FILENAME='../from_different_sides.py'
DIRNAME='plane'

# alias blender=/Applications/blender.app/Contents/MacOS/blender

# Training dense pos
blender $BLENDER_FILENAME -b -P $PYTHON_FILENAME -- \
	--output_dir $DIRNAME --dataset_name training --n_images 500 \
	--r 2 5 --vary_origin 0.8 --origin 0 0 0 \
	--width 256 --height 256 \
	--spherical -3.14159 3.14159 0 3.14159 --factor 4

# Validation dataset
blender $BLENDER_FILENAME -b -P $PYTHON_FILENAME -- \
	--output_dir $DIRNAME --dataset_name validation --n_images 70 \
	--r 2 5 --vary_origin 0.8 --origin 0 0 0 \
	--width 256 --height 256 \
	--spherical -3.14159 3.14159 0 3.14159

# Test 1
blender $BLENDER_FILENAME -b -P $PYTHON_FILENAME -- \
	--output_dir $DIRNAME --dataset_name test1 --n_images 180 \
	--r 3.5 3.5 --vary_origin 0 --origin 0 0 0 \
	--width 256 --height 256 \
	--linear -3.14159 3.14159 1.2 1.2

# Test 2
blender $BLENDER_FILENAME -b -P $PYTHON_FILENAME -- \
	--output_dir $DIRNAME --dataset_name test2 --n_images 90 \
	--r 3.5 3.5 --vary_origin 0 --origin 0 0 0 \
	--width 256 --height 256 \
	--linear 0.8 0.8 0.1 3.0416