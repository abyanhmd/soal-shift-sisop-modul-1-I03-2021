#!/bin/bash
export LC_ALL=C
input="/home/mukhoram/Downloads/Laporan-TokoShiSop.tsv"
awk -F "\t" '
BEGIN{printf "customer list of albuquerque at 2017\n"}
{
	{if(NR!=1)
		{
			{if($10~"Albuquerque" && $3 ~ /17$/)
					a[$7]++
			}
		}
	}
}
END{ for(b in a){ print b} {printf "\n"}}
' "$input" >> hasil.txt
