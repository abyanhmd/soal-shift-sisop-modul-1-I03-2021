## README

### **Number 1**
**a. Show Log Info Using Regex**</br>
The information that is required to be displayed are log type (ERROR/INFO), log messages, and the username
on each log line. The regex to display all the INFO and ERROR messages can be like this</br>

```shell
grep -o "[INFO|ERROR].*" syslog.log | cut -d":" -f2
```

The grep command is to find a pattern of a text file that can be word, number, and etc.
The -o option means only matching certain word that is typed after.
The regex that is used in this function is

```regex
[INFO|ERROR].*
```
The regex is to show every INFO or ERROR until the end of the line (.*).
Because the file is in the same directory, we can simply type the name of the file which in this case is syslog.log file. </br>
In order to run this program, we need to cut the date log for each of the line by using cut command. The -d":" option is to limit the line before and after ":" character and use -f2 to show the second field of the ":" character.</br></br>

**b. Display All ERROR Messages With The Number Of Occurences**</br>
Displaying all the error and count each of the occurences can be commanded like this</br>

```shell
grep -E -o “ERROR.*” syslog.log | cut -d”(” -f1 | sort -d | uniq -c | sort -n -r
```

The grep and the cut commands are the same with the previous question but the difference is only in the character in the cut command. The cut command uses "(" character and the first field of it.</br>
The sort -d command is to sort all of the output alphabetically (dictionary order).</br>
The uniq command is to filter adjacent matching lines from the output and the -c option is to count the lines based on the number of occurences.</br>
The last sort command is to sort number from the smallest to the highest value using (-n) and to reverse the sorting to be the highest to the smallest value (-r).</br></br>
It can also be stored to each variable manually like

```shell
denyinfo="$(grep -E 'Permission denied while closing ticket' syslog.log | wc -l)"
modinfo="$(grep -E 'The ticket was modified while updating' syslog.log | wc -l)"
closedinfo="$(grep -E 'Tried to add information to closed ticket' syslog.log | wc -l)"
timeinfo="$(grep -E 'Timeout while retrieving information' syslog.log | wc -l)"
existinfo="$(grep -E 'exist' syslog.log | wc -l)"
connectinfo="$(grep -E 'Connection to DB failed' syslog.log | wc -l)"
```
The wc command is to count the total of the words that is already typed and the words that are used for the grep command need to be specific and will take a lot of time to find for each error log messages.</br></br>

**c. Display The Number Of Occurences Of The ERROR And INFO Log For Each User**</br>
Displaying ERROR and INFO with the user can also use grep and cut command. For the INFO log

```shell
grep -E -o 'INFO.*' syslog.log | cut -d"(" -f2 | cut -d")" -f1 | sort -d | uniq -c
```
And for the ERROR log

```shell
grep -E -o 'ERROR.*' syslog.log | cut -d"(" -f2 | cut -d")" -f1 | sort -d | uniq -c
```
The command that is used for this question is basically the same with the previous question and the difference is only the character in the cut command. The cut command with the ")" character and -f1 for the first field is to cut the ")" character and display the left field of the character.</br></br>

**d. List The ERROR Log From The Number Of Occurences Descendingly**</br>
We can use the variables that are used from the (b) question before and echo it to the error_message.csv file.

```shell
echo "Error, Count" >> error_message.csv
echo "Timeout while retrieving information, $timeinfo" >> error_message.csv
echo "Failed to connect to DB, $connectinfo" >> error_message.csv
echo "Tried to add information to closed ticket, $closedinfo" >> error_message.csv
echo "Permission denied, $denyinfo" >> error_message.csv
echo "The ticket was modified while updating, $modinfo" >> error_message.csv
echo "File not found, $existinfo" >> error_message.csv
```
It basically print out the variable command to the error_message.csv file.</br></br>

**e. Display The Username With The Total INFO And ERROR**</br>
In order to display the username and the the total INFO and ERROR, we need to make a loop to determine and print out the username with its INFO and ERROR. The loop can be like this

```shell
name="$(cat syslog.log | cut -d"(" -f2 | cut -d")" -f1 | sort -d | uniq -d)"
echo "$name" |
while read user
do
	totinfo=`grep -E -o "INFO.*($user)" syslog.log | wc -l`
	toterror=`grep -E -o "ERROR.*($user)" syslog.log | wc -l`
	echo "$user, $totinfo, $toterror"
done|sed "1 i\Username, INFO, ERROR" >> user_statistic.csv
```
Firstly, store all of the username with cat, cut, uniq, and sort command into a variable. And then, the loop includes a new variable, the command to total the INFO and ERROR for each user with the new variable inside the command to match the user and with the username before (INFO.*($user)). After that, we sed it with 1 for the initial line because the first line that is required to be printed is Username, INFO, ERROR and i for the iteration. Finally, store all of the data above to user_statistic.csv file.

### **NUMBER 2**
**a.  Look for the largest row ID and profit percentage. The profit percentage is calculated using the formula (profit / cost price) X 100 **</br>
```shell 
BEGIN{printf "transaction with the biggest profit precentage" }

{

{if(NR!=1)

max=0;idmax=0

profitpercentage=(($21/($18-$21))*100)

id=$1

{if(profitpercentage>=max)

{

max=profitpercentage

idmax=id}
}}}

END{printf " %d with precentage of %.2f%%.\n\n", idmax, max}

' "$input" >> hasil.txt
```
First we use LC_ALL=C so that we can get the right decimal numbers. Second we begin it by initializing max ( maximum profit ) by zero. Then we start nr>1 because we need the process started by row 2. And then we used the operation that given before to calculate the profit percentage. Maximum will equalized with profit percentage. Also, if the profit percentage is already determined, it will be printed to hasil txt.

**b. Looking for customer that doing transaction at albuquerque at 2017.**</br>
```shell
awk -F "\t" '

BEGIN{printf "customer list of albuquerque at 2017\n"}

{

{if(NR!=1)

{

{if($10~"Albuquerque" && $3 ~ /17$/)

a[$7]++}
}}}

END{ for(b in a){ print b} {printf "\n"}}

' "$input" >> hasil.txt
```
starting the code if the line != 1. checking if Albuquerque is 10$ city and $3 (Date) is in 2017, then customer will be stored at a[&7] array.
after END, we loop the data of customer and print it afterwards.

**c. Looking for customer segment and the number of transactions with the least amount of transactions.**</br>
```shell
awk -F"\t" '

BEGIN {printf("the least segment type is")}

{segment=$8

if (NR != 1)

count[segment]++}

END {type=0;min=99999;

for (segment in count) {

if (min > count[segment]) {

min=count[segment]
type=segment}
}
printf(" %s with %s\n" , type, min)

}' "$input" >> hasil.txt
```
starting using count[segment] to checking the segments and adding space to it. starting the code if the line != 1.
we use the min and type to store the segment type and the spaces of it. then we use loop to calculate the smallest of the segments. lastly, we output it to hasil.txt.

**d. Looking for region that has the least total profit and the total profit of that region.**</br>
```shell
awk -F"\t" '

BEGIN {printf("the region with the least profit is ")}

{profit=$21;region=$13;

if (NR != 1)

count[region] = count[region] + profit;}

END {type=0;min=9999999999;

for (region in count) {

if (min > count[region]) {

min=count[region]

type=region}
}
printf("%s with total %f\n", type, min)
}' "$input" >> hasil.txt
```

first we save the region in count[region], the to accumulate the profit with it, we add it to count[region]+profit. then we loop the region. to search the minimum, we used the if(min > count[region]). after that, the type is used to save the region name. lastly, we output it to the hasil.txt


### **NUMBER 3**
**a. Download 23 images save the logs and rename it**</br>
First we need to download images from https://loremflickr.com/320/240/kitten, then we check for any duplicates images, if there is any of it delete the duplicates then rename all the images with "Koleksi_xx".
```shell 
for (( i=0 ; i<23 ; i=i+1 ))
	do
	wget --content-disposition https://loremflickr.com/320/240/kitten -a 'Foto.log'
	done
rm *.jpg.*
j=1
for i in *.jpg
	do
	mv "$i" Koleksi_"$j".jpg
	let j=j+1
	done
```
We use ``wget --content-disposition`` to download the images as the original name so we can easily check for any duplicates. if not the images name will be kitten.jpg and we use ``-a 'Foto.log'`` to save the log.
Next we remove duplicates with ``rm *.jpg.*`` and rename all the images incrementally.</br>

**b. Run the script at 20:00 PM and move it to a folder**</br>
We want to run the previous script at 20:00 PM starting the 1st every seven days (1,8...) and 2nd once every four days (2,6..) and move all the images and the log into folder with the download date.
```shell
for (( i=0 ; i<23 ; i=i+1 ))
	do
	wget --content-disposition https://loremflickr.com/320/240/kitten -a 'Foto.log'
	done
rm *.jpg.*
	
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
```
The code pretty similiar with the previous number we just need to make a folder with ``mkdir``command and use ``"$(date +%d-%m-%Y)"``to set the download date. we use ``cp *.jpg $folder_name``  to copy all the images to the folder name then we use ``rm *.jpg`` to remove all images that have been moved to the folder and we use ``mv Foto.log $folder_name`` to move the log to the folder.
for the crontab we use 
```shell
0 20 1/7,2/4  *  * bash home/hilmythoriq/soal3b.sh
```
``0 20`` represent the 20:00 PM time, ``1/7,2/4`` represent every seven days start from 1st and every 4 days starts from 2nd.</br>

**c. Download bunny images alternately and rename the folder name**</br>
First we need to decide what images we have to download, if we download kitten we make folder named ``Kucing_date`` if we download bunny we make folder named ``Kelinci_date`` with the download date.
```shell
kucCount=`ls | grep -E 'Kucing_*'| wc -l `
kelCount=`ls | grep -E 'Kelinci_*'| wc -l`
if [ $kucCount -ge $kelCount ]
	then
		eng="bunny"
		ind="Kelinci"
	else
		eng="kitten"
		ind="Kucing"
fi
for (( i=0;i< 24;i=i+1 ))
	do
	wget --content-disposition https://loremflickr.com/320/240/$eng -a 'Foto.log'
	done
j=1
for i in *.jpg
	do
		mv "$i" Koleksi_"$j".jpg
		let j=j+1
	done
	
rm *.jpg.*

folder_name=$ind"_$(date +%d-%m-%Y)"

mkdir $folder_name
cp *.jpg $folder_name
rm *.jpg
mv Foto.log $folder_name
```
To count the emergence of bunny and kitten folder we use ``ls | grep -E 'Kucing_*'| wc -l ``  and `ls | grep -E 'Kelinci_*'| wc -l `. If there is no both folder we starts from bunny.
We use variable `eng` to changes the url download based on what we want to download and variable `ind` to rename the folder.
the rest of the code pretty similiar as the previous code. </br>

**d. Secure the download images and log into zip** </br>
We want to zip all the folder and lock the zip with the current date.
```shell
jam=`date +%H`
if [[ $jam == 07 ]]
	then
		zip -r -P $(date +%m%d%Y) Koleksi.zip */
		rm -r */
elif [[ $jam == 18 ]]
	then
		unzip -P $(date +%m%d%Y) Koleksi.zip
		rm Koleksi.zip
fi
```
first we assign the current date and hours with `date +%H`cause the question pretty similiar with the e. question we decided to check the time in this script. 

if it is 7:00 AM we use zip all the folder named `Koleksi.zip`. We use `-r` to move all images and log inside the folder to the zip if we dont use `-r` the folder will be empty.
next we use `rm -r */`to remove all moved folder.

if it is 18:00 PM we unzip it and we use `rm Koleksi.zip` to delete the zip.

to set the zip password with the current date we use `-P $(date +%m%d%Y)`.</br>

**e. Run the script every day except saturday and sunday**</br>
We want to run the script every day except saturday and sunday and zip all the folder at 07:00 AM and unzip it at 18:00 PM.
```shell
0 7,18 * * 1-5 bash home/hilmythoriq/soal3d.sh
```
We use `0 7,18` to make the crontab run the script every 7:00 AM and 18:00 PM. Next we use `1-5` to make it run every day except saturday and sunday


