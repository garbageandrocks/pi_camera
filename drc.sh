#!/bin/bash

PS3="Select Dynamic Range Compression option: "

OPTIONS="off low med high quit" 

select opt in $OPTIONS; 
do
	case $opt in
    "off")
      ;&
    "low")
      ;&
    "med")
      ;&
    "high")
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


