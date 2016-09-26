#!/bin/bash

PS3="Set Exposure mode: "

OPTIONS="off auto night nightpreview backlight spotlight sports snow beach verylong fixedfps antishake fireworks quit" 

select opt in $OPTIONS; 
do
	case $opt in
    "off")
      ;&
    "auto")
      ;&
    "night")
      ;&
    "nightpreview")
      ;&
    "backlight")
      ;&
    "spotlight")
      ;&
    "sports")
      ;&
    "snow")
      ;&
    "beach")
      ;&
    "verylong")
      ;&
    "fixedfps")
      ;&
    "antishake")
      ;&
    "fireworks")
      DATE=$(date +"%Y-%m-%d_%H%M%S")
		  echo "raspistill -hf -awb $opt -o /home/pi/photos/$DATE.jpg"
		  raspistill -hf -ex $opt -o /home/pi/photos/$DATE.jpg		
      ;;
    "quit")
      echo goodnight sweet prince
		  exit
      ;;
    *)
      echo invalid response, try again dummy
      ;;
  esac
done


