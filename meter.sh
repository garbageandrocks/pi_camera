#!/bin/bash

PS3="Select Meter mode: "

OPTIONS="average spot backlit matrix quit" 

select opt in $OPTIONS; 
do
	case $opt in
    "average")
      ;&
    "spot")
      ;&
    "backlit")
      ;&
    "matrix")
      DATE=$(date +"%Y-%m-%d_%H%M%S")
		  echo "raspistill -hf -awb $opt -o /home/pi/photos/$DATE.jpg"
		  raspistill -hf -awb $opt -o /home/pi/photos/$DATE.jpg		
      ;;
    "quit")
      echo goodbye my friend
		  exit
      ;;
    *)
      echo invalid response
      ;;
  esac
done


