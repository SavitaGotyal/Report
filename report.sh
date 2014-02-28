#!/bin/bash
# --------------------------------------------------------------------------------------------------------------------------
#[Author] Savita and Kavyashree
#
#Description:This programs generate report for all the users who logged in and gives login details like: Rank:Gives rank #depending on number of times user logged in, User:Name of user who logged in to the system, Login date:First time user #logged in Number of logins:Gives how many times user logged in. Total Usage time:Total time the user was active.
#
#Last Modified: 01/24/2014
#---------------------------------------------------------------------------------------------------------------------------

if [[ $1 = "--help" ]]
then
	echo "This program generates login report for the users.Gives followng information:Rank,User, Login Date,Number of 		logins, Total usage time"

	echo "---------------------------------------------------"
	
	echo "To run program: bash report"

	echo "---------------------------------------------------"
	
	exit
fi


printf "%-4s %-10s %-12s %-15s %-15s\n" "Rank" "User" "Login Date" "Number of Logins" "Total Usage Time" 

last | head -n -2 > users.log  #search for users in /var/log/wtmp extact top 3 rows and place in users file

cat users.log | cut -d' ' -f1 | sort | uniq >> usernames.log #get unique users name by delimiting ' '
(while read user; #for each user 
 do
	grep ^$user users.log > duser.log #from users file grep only info of $user
	sec=0 
	constant_value=1393180200 # %s displays time since 1970 
	while read totaltimes;
 	do
   		s=$(date -d $totaltimes +%s 2> time.log) ##To convert the duration from login time to seconds
	
		if [[ ! -z $s  ]] #To remove empty string
		then		
						
			let s=s-constant_value # %s displays time since 1970,subtract it from current time.
		fi		 		
		
		
		let sec=sec+s #like expr, let command used for calculate worked hours
			
	done < <(cat duser.log | awk '{ print $NF }' | tr -d ')(') #delimiting () extract time of hour loginned, $NF give 		number of fields

	if [[ $user = "savita" ]]
	then
		firstlog=$(tail -n 1 duser.log | awk '{ print $4,$5,$6 }') #extract 4th 5th n 6th field which give login date day and  time
	elif [[ $user = "reboot" ]]
	then
		firstlog=$(tail -n 1 duser.log | awk '{ print $5,$6,$7 }')
	else
		firstlog=$(tail -n 1 duser.log | awk '{ print $3,$4,$5 }')
	fi
	
	
	if [[ $sec -lt 60 ]];then #check the ime for min hur day months
		secs="S"
		hours=$(echo "$sec/(1.0) " |bc )
		hours=$hours$secs	
	elif [[ $sec -gt 60 && $sec -lt 3600 ]];then
		minutes="M"
		hours=$(echo "$sec/(60.0) " |bc )
		hours=$hours$minutes
	elif [[ $sec -ge 3600 && $sec -lt 86400 ]]
	then
		days="H"
		hours=$(echo "$sec/(3600.0) " |bc )
		hours=$hours$days	
	elif [[ $sec -ge 86400 && $sec -lt 2592000 ]];then
		months="D"
		hours=$(echo "$sec/(86400.0) " |bc )
		hours=$hours$months		
	elif [[ $sec -ge 2592000 ]];then
		year="months"
		hours=$(echo "$sec/(2592000.0) " |bc )
		hours=$hours$year
	fi
	
	nlogins=$(cat duser.log | wc -l) #number lines intern number of login of same user calculated from duser file
	
	printf "%-10s %-15s %-15s %-15s\n" $user "$firstlog"  $nlogins $hours 
done < usernames.log #input of user taken from usernames file
)|sort -nrk 3 | awk '{ printf("%-4s %s\n", NR, $0) }' # sort number of logins to get the rank of user using sort -nrk and awk is used to assign rank i.e., 1,2,3
rm usernames.log users.log duser.log 


