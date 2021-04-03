#2a

#!/bin/bash
export LC_ALL=C
input="/home/mukhoram/Downloads/Laporan-TokoShiSop.tsv"

awk -F "\t" '
BEGIN{printf "transaction with the biggest profit precentage" }
{
	{if(NR!=1)
	max=0;idmax=0
	profitpercentage=(($21/($18-$21))*100)
	id=$1
		{if(profitpercentage>=max)
		{
		max=profitpercentage
		idmax=id
}
}
}
}
END{printf " %d with precentage of %.2f%%.\n\n", idmax, max}
' "$input" >> hasil.txt

#2b
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

#2c
#!/bin/bash
export LC_ALL=C
input="/home/mukhoram/Downloads/Laporan-TokoShiSop.tsv"
awk -F"\t"  '
BEGIN {printf("the least segment type is")}
{segment=$8
    if (NR != 1)  
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

#2d
#!/bin/bash
export LC_ALL=C
input="/home/mukhoram/Downloads/Laporan-TokoShiSop.tsv"
awk -F"\t"  '
BEGIN {printf("the region with the least profit is ")}
{profit=$21;region=$13;
    if (NR != 1)  
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

