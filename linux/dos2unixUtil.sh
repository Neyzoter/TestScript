#!/bin/bash

echo "Please input file name ..."
read file

echo "Overwrite?[y/n]"
read overwrite

if [ $overwrite = "y" ]; then
  dos2unix $file
else
  echo "Please input file name ..."
  read newFile
  dos2unix -k -n $file $newFile
fi

cat -e $file | head -n 1


