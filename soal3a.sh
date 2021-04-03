#!/bin/bash

# * Downloads file
for (( i=0 ; i<23 ; i=i+1 ))
do
wget --content-disposition https://loremflickr.com/320/240/kitten -a 'Foto.log'
done

# * remove duplicates with jpg
rm *.jpg.* 

# # * Rename .jpg incrementing
j=1
for i in *.jpg
do
mv "$i" Koleksi_"$j".jpg
let j=j+1
done

