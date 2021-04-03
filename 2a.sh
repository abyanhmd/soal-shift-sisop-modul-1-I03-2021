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
