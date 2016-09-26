#!/bin/bash

PS3="Select an Image Effect: "

OPTIONS="none negative solarise sketch denoise emboss oilpaint hatch gpen pastel watercolour film blur saturation colourswap washedout posterise colourpoint colourbalance cartoon quit" 

opt="$(iselect -a -S $OPTIONS)"
  case $opt in
    none)
      ;&
    "negative")
      ;&
    "solarise")
      ;&
    "sketch")
      ;&
    "denoise")
      ;&
    "emboss")
      ;&
    "oilpaint")
      ;&
    "hatch")
      ;&
    "gpen")
      ;&
    "pastel")
      ;&
    "watercolour")
      ;&
    "film")
      ;&
    "blur")
      ;&
    "saturation")
      ;&
    "colourswap")
      ;&
    "washedout")
      ;&
    "posterise")
      ;&
    "colourpoint")
      ;&
    "colourbalance")
      ;&
    "cartoon")
      DATE=$(date +"%Y-%m-%d_%H%M%S")    
      echo "raspistill -hf -ifx $opt-o /home/pi/photos/$DATE.jpg"
		  raspistill -hf -ifx $opt -o /home/pi/photos/$DATE.jpg
      ;;
    "quit")
      echo goodbye
		  exit
      ;;
    *)
      echo invalid response
      ;;
  esac


