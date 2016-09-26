#!/bin/bash

PS3="Select Automatic White Balance mode: "

OPTIONS="off auto sun cloud shade tungsten fluorescent incandescent flash horizon quit" 

select opt in $OPTIONS; 
do
	case $opt in
    "off")
      ;&
    "auto")
      ;&
    "sun")
      ;&
    "cloud")
      ;&
    "shade")
      ;&
    "tungsten")
      ;&
    "fluorescent")
      ;&
    "incandescent")
      ;&
    "flash")
      ;&
    "horizon")
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


