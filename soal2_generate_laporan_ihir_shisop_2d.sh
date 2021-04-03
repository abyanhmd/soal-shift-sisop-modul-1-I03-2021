#!/bin/bash
export LC_ALL=C
input="/home/mukhoram/Downloads/Laporan-TokoShiSop.tsv"
awk -F"\t"  '
BEGIN {printf("the region with the least profit is ")}
{profit=$21;region=$13;
    if (NR == 1) next 
    count[region] = count[region] + profit;
} 
END {type=0;min=9999999999;
for (region in count) {
    if (min > count[region]) {
            min=count[region]
            type=region
        }
}
printf("%s with total %f\n", type, min)
}' "$input" >> hasil.txt
