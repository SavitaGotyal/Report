#!/bin/bash

###################################################################################################################################################################################################
#    Author        : Kavyashree V and Savita.                                                                                                                                                     #
#    Description   : A simple script to print the numbers 1 through n, one on each line. n will be speciﬁed as a command line argument but if it is not speciﬁed,default value of 20.If the       #
#                    number to be printed is divisible by 3, string Fizz is printed. If the number is divisible by 5, string Buzz is printed. If the number is divisible by both 3 and 5, the     # #        	     string FizzBuzz is printed.																		  #
#    Last Modified : 25/02/2014.								                								  		  #
###################################################################################################################################################################################################


#assigns command line argument to n.

n=$1  

##########to check if n is number
echo $n|egrep '^[0-9]+$' 


#####checks if user has given valid input if not default value 20 is taken.
if ! [ $? -eq 0 ]||[ $n == '' ] 

then 
   
	echo "As no input given by user,Default number 20 is taken:"
   
	n=20
fi

########Display Number
echo "Number : $n"

#######intial value 1
a=1

##########checking for division
while [ $a -le $n ]
do
  m=`expr $a % 5` 
  l=`expr $a % 3` 
  
  
  if [ $m -eq 0 ]&&[ $l -eq 0 ] #checks if number is divisible by 5 and 3.
  then
	echo "	fizzbuzz"
  elif [ $l -eq 0 ] #checks if number is divisible by 3.
  then 
  	echo "	fizz"
  elif [ $m -eq 0 ] #checks if number is divisible by 5.
  then
  	echo "	buzz"
  else
	echo "$a"
  fi
  
   a=`expr $a + 1`
done
