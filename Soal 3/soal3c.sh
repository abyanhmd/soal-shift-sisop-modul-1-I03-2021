#!/bin/bash

kucCount=`ls | grep -E 'Kucing_*'| wc -l `
kelCount=`ls | grep -E 'Kelinci_*'| wc -l`

#Bunny first then kitten
if [ $kucCount -ge $kelCount ]
then
    eng="bunny"
    ind="Kelinci"
else
    eng="kitten"
    ind="Kucing"
fi


# * Downloads file, but if the same file name exist, then don't
for (( i=0;i< 24;i=i+1 ))
do
wget --content-disposition https://loremflickr.com/320/240/$eng -a 'Foto.log'
done

# * Rename .jpg files inside to incrementing name
j=1
for i in *.jpg
do
	mv "$i" Koleksi_"$j".jpg
	let j=j+1
done

# * remove duplicates
rm *.jpg.* 

folder_name=$ind"_$(date +%d-%m-%Y)"

mkdir $folder_name
cp *.jpg $folder_name
rm *.jpg
mv Foto.log $folder_name
