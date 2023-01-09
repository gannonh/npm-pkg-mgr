#!/bin/bash

find . -type d -name 'piece-*' -execdir bash -c 'mv "$1" "${1/piece-/spark_}"' bash {} \;