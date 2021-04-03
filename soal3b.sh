#!/bin/bash

# * Downloads file
for (( i=0 ; i<23 ; i=i+1 ))
do
wget --content-disposition https://loremflickr.com/320/240/kitten -a 'Foto.log'
done

# * remove duplicates with jpg
rm *.jpg.* 

# # * Rename .jpg files incrementing
j=1
for i in *.jpg
do
mv "$i" Koleksi_"$j".jpg
let j=j+1
done

folder_name="$(date +%d-%m-%Y)"

mkdir $folder_name
cp *.jpg $folder_name
rm *.jpg
mv Foto.log $folder_name

