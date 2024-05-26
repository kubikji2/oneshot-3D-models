#!/bin/env bash

openscad input-cover.scad -o "input-cover-left.stl" -D "is_parrot=false" -D "is_left=true"


openscad input-cover.scad -o "input-cover-left-parrot.stl" -D "is_parrot=true" -D "is_left=true"



openscad input-cover.scad -o "input-cover-right.stl" -D "is_parrot=false" -D "is_left=false"


openscad input-cover.scad -o "input-cover-right-parrot.stl" -D "is_parrot=true" -D "is_left=false"