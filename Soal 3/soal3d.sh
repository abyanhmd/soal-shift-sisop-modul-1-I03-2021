#!/bin/bash

jam=`date +%H`

if [[ $jam == 07 ]]
then
    zip -r -P $(date +%m%d%Y) Koleksi.zip */
    # remove all zip
    rm -r */
elif [[ $jam == 18 ]]
then
    unzip -P $(date +%m%d%Y) Koleksi.zip
    rm Koleksi.zip
fi
