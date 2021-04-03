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
