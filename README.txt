1.
a)  We can simply use ( grep -E “INFO” syslog.log ) to show all of the info from the syslog file and ( grep -E “ERROR” syslog.log ) for the error from the syslog file.

b) To display all of the error messages and the number of the occurences, we can store to a variable for each of the error by using 
denyinfo="$(grep -E 'Permission denied while closing ticket' syslog.log | wc -l)" 
modinfo="$(grep -E 'The ticket was modified while updating' syslog.log | wc -l)"
closedinfo="$(grep -E 'Tried to add information to closed ticket' syslog.log | wc -l)"
timeinfo="$(grep -E 'Timeout while retrieving information' syslog.log | wc -l)"
existinfo="$(grep -E 'exist' syslog.log | wc -l)"
connectinfo="$(grep -E 'Connection to DB failed' syslog.log | wc -l)"
It basically search the same words between the command and the syslog file and count it in one by one.

For the faster way, we can use 
grep -E -o “ERROR.*” syslog.log | cut -d”(” -f1 | sort -d | uniq -c | sort -n -r
grep command is to show all the from the ERROR to end of each line of the syslog.
cut command is to distinguish between before and after ‘(‘ character.
sort command is to sort the log alphabetically.
uniq comannd is to count each of the same sentence and sort of merge it out.
another sort is to sort the number of the uniq descending after it was counted by uniq.

c) cannot be solved, not understand it yet

d) In order to print from the b question, we can use the same variable before
echo "Error, Count" >> error_message.csv
echo "Timeout while retrieving information: $timeinfo" >> error_message.csv
echo "Failed to connect to DB, $connectinfo" >> error_message.csv
echo "Tried to add information to closed ticket: $closedinfo" >> error_message.csv
echo "Permission denied, $denyinfo" >> error_message.csv
echo "The ticket was modified while updating: $modinfo" >> error_message.csv
echo "File not found, $existinfo" >> error_message.csv
 
e) cannot be solved, not understand it yet


2.
a)
Look for the largest row ID and profit percentage. The profit percentage is calculated using the formula (profit / cost price) X 100

#!/bin/bash
export LC_ALL=C

awk -F '\t' BEGIN{max=0;}
NR>1
{ profit_persen=$21/($18-$21) *100;
if profit_persen >= max;
max=profit_persen;
rowID=$1;
}END {
printf {"%d",max}

First we use LC_ALL=C so that we can get the right decimal numbers. Second we begin it by initializing max ( maximum profit ) by zero. 
Then we start nr>1 because we need the process started by row 2. And then we used the operation that given before to calculate the profit percentage. 
Maximum will equalized with profit percentage. Also, if the profit percentage is already determined, it will be printed. (this is an unfinished solution)

b. cannot be solved not understand yet
c. cannot be solved not understand yet
d. cannot be solved not understand yet


3.
a) We need to make a script that download a pic 23 times and put the log into file called ‘Foto.log’
We can use wget or curl to download file then to make it 23 times we use for I in {1..23} to make it looping and rename the file sequentially to rename it we use “-O” command .
and then we check if the downloaded file is not duplicated if its duplicated we have to download another one but we not do this in our code we not understand how to do it.
b) We make a crontab that run the 3a script at 8 pm every 7 days from 1st of the month and every 4 days from 2nd  of the month. We use 0 20 */7 * * for every 7 days and 0 20 2/4 * * for every 4 days starts from 2nd 
and then we have to put the picture and the log to a folder with the name as the download date. but we not do this in our code we not understand how to do it.

c) cannot be solved not understand yet
d) cannot be solved not understand yet
e) cannot be solved not understand yet

