#!/bin/bash

echo line1
echo line2
echo -e "line3\nLine4\tLine5"
echo -e "\e[32m this is to practice the colour \e[0m"

a=10
b=20
c=30
echo value of the a is $a
todays_date=$(date +%F)
echo "todays date is ${todays_date}"
echo $0
echo "name of the script is $0"
echo "name the teacher is $1"
echo "name of the institute is $2"
echo "name of the batch is $3"
echo $*
echo $$
echo $#
echo $?

sample(){
echo "this is the sample function"
echo "i am creating the sample function"
echo " sample function is created"    
}
# declearing the sample function

smple