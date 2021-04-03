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

