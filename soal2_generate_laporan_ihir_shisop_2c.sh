#!/bin/bash
export LC_ALL=C
input="/home/mukhoram/Downloads/Laporan-TokoShiSop.tsv"
awk -F"\t"  '
BEGIN {printf("the least segment type is")}
{segment=$8
    if (NR == 1) next 
    count[segment]++
} 
END {type=0;min=99999;
for (segment in count) {
    if (min > count[segment]) {
        min=count[segment]
        type=segment
    }
}
    printf(" %s with %s\n" , type, min)
}' "$input"  >> hasil.txt

