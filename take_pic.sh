#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M%S")    
raspistill -hf -ifx gpen -o /home/pi/photos/$DATE.jpg

