#!/bin/bash
#
# Simple UI API for selecting camera settings for raspivid command and saving params in a config file


# raspivid Camera App v1.3.12
# 
# Display camera output to display, and optionally saves an H264 capture at requested bitrate
# 
# 
# usage: raspivid [options]
# 
# Image parameter commands
# 
# -?, --help	: This help information
# -w, --width	: Set image width <size>. Default 1920
# -h, --height	: Set image height <size>. Default 1080
# -b, --bitrate	: Set bitrate. Use bits per second (e.g. 10MBits/s would be -b 10000000)
# -o, --output	: Output filename <filename> (to write to stdout, use '-o -')
# -v, --verbose	: Output verbose information during run
# -t, --timeout	: Time (in ms) to capture for. If not specified, set to 5s. Zero to disable
# -d, --demo	: Run a demo mode (cycle through range of camera options, no capture)
# -fps, --framerate	: Specify the frames per second to record
# -e, --penc	: Display preview image *after* encoding (shows compression artifacts)
# -g, --intra	: Specify the intra refresh period (key frame rate/GoP size). Zero to produce an initial I-frame and then just P-frames.
# -pf, --profile	: Specify H264 profile to use for encoding
# -td, --timed	: Cycle between capture and pause. -cycle on,off where on is record time and off is pause time in ms
# -s, --signal	: Cycle between capture and pause on Signal
# -k, --keypress	: Cycle between capture and pause on ENTER
# -i, --initial	: Initial state. Use 'record' or 'pause'. Default 'record'
# -qp, --qp	: Quantisation parameter. Use approximately 10-40. Default 0 (off)
# -ih, --inline	: Insert inline headers (SPS, PPS) to stream
# -sg, --segment	: Segment output file in to multiple files at specified interval <ms>
# -wr, --wrap	: In segment mode, wrap any numbered filename back to 1 when reach number
# -sn, --start	: In segment mode, start with specified segment number
# -sp, --split	: In wait mode, create new output file for each start event
# -c, --circular	: Run encoded data through circular buffer until triggered then save
# -x, --vectors	: Output filename <filename> for inline motion vectors
# -cs, --camselect	: Select camera <number>. Default 0
# -set, --settings	: Retrieve camera settings and write to stdout
# -md, --mode	: Force sensor mode. 0=auto. See docs for other modes available
# -if, --irefresh	: Set intra refresh type
# -fl, --flush	: Flush buffers in order to decrease latency
# -pts, --save-pts	: Save Timestamps to file for mkvmerge
# -cd, --codec	: Specify the codec to use - H264 (default) or MJPEG
# -lev, --level	: Specify H264 level to use for encoding
# 
# 
# H264 Profile options :
# baseline,main,high
# 
# 
# H264 Level options :
# 4,4.1,4.2
# 
# H264 Intra refresh options :
# cyclic,adaptive,both,cyclicrows
#
#

TRUTH=("true" "false")
CODEC=("H264" "MJPEG")
PROFILE=("baseline" "main" "high")
LEVEL=("4" "4.1" "4.2")
REFRESH=("cyclic" "adaptive" "both" "cyclicrows")
STATE=("record" "pause")
OPTIONS=("width" "height" "bitrate" "output" "verbose" "timeout" "demo" "framerate" "penc" "intra" "profile" "timed" "signal" "keypress" "initial" "qp" "inline" "segment" "wrap" "start" "split" "circular" "vectors" "camselect" "mode" "irefresh" "flush" "save-pts" "codec" "level" "quit")
MODE=("0" "1" "2" "3" "4" "5" "6" "7")

#
# function:     select_on_array
# description:  selects value based on array and stores selected value in a variable 
# input:        ps3_str, list, out_var
# output:       out_var
#
select_array()
{
	# label input params
	ps3_str=$1
	array=("${!2}")
	out_var=$3

	PS3=$ps3_str

	select val in ${array[@]}; 
	do
	    for i in ${!array[@]}; do
			if [ $val == ${array[i]} ]; then
				eval "$out_var=$val"
				return
			fi
		done
	done
}

#
# function:     read_number
# description:  gets a numeric input from user and stores in variable
# input:        echo_str, out_var
# output:       out_var
# 
read_number()
{
	# label input params
	echo_str=$1
	out_var=$2

	read_val=""
	while [[ ! $read_val =~ ^[0-9]+$ ]]
	do
		echo $echo_str
		read read_val
	done

	eval "$out_var=$read_val"	
}

#
# function:     read_filename
# description:  gets a valid filename from user and stores in variable
# input:        echo_str, out_var
# output:       out_var
# 
read_filename()
{
	# label input params
	echo_str=$1
	out_var=$2

	read_val=""
	while [[ ! $read_val =~ ^[a-zA-Z]+[*a-zA-Z0-9_]+$ ]]
	do
		echo $echo_str
		read read_val
	done

	eval "$out_var=$read_val"	
}

#
# function:     write_vars_to_file
# description:  writes an array of variable to a file
# input:        array, filename, header_str, footer_str
# output:       filename.txt
# 
write_vars_to_file()
{
	# label input params
	array=("${!1}")
    filename=$2
    header_str=$3
    footer_str=$4

	PS3=$ps3_str

    echo $header_str > $filename.txt

    for i in ${!array[@]}; do
        echo ${array[i]} >> $filename.txt
	done

    echo $footer_str >> $filename.txt
}
main()
{
    #initialize empty array
    for i in ${!OPTIONS[@]}
    do
        config_vars[i]="blank"
    done

    while true    
    do
    select_array "Choose a raspivid option: " OPTIONS[@] opt
        case $opt in
            "width")
                read_number "Enter desired width (default 1920): " config_vars[0]
                ;;
            "height")
                read_number "Enter desired height (default 1080): " config_vars[1]
                ;;
            "bitrate")
                read_number "Enter desired bitrate (bits per second): " config_vars[2]
                ;;
            "output")
                read_filename "Specify output file name: " config_vars[3]
                ;;
            "verbose")
                select_array "Turn on verbose output: " TRUTH[@] config_vars[4]
                ;;
            "timeout")
                read_number "Enter desired timeout (5 seconds if not specified. Zero to disable): " config_vars[5]
                ;;
            "demo")
                select_array "Turn on demo mode: " TRUTH[@] config_vars[6]
                ;;
            "framerate")
                read_number "Enter desired framerate (frames per second to record): " config_vars[7]
                ;;
            "penc")
                select_array "Display preview image after encoding: " TRUTH[@] config_vars[8]
                ;;
            "intra")
                read_number "Enter desired intra refresh period (key frame rate/GoP size): " config_vars[9]
                ;;
            "profile")
                select_array "Specify H264 encoding profile: " PROFILE[@] config_vars[10]
                ;;
            "timed")
                read_number "Enter desired record time: " config_vars[11]
                read_number "Enter desired pause time:  " config_vars[12]
                ;;
            "signal")
                select_array "Cycle between capture and pause on signal: " config_vars[13]			
                ;;
            "keypress")
                select_array "Cycle between capture and pause on keypress: " config_vars[14]
                ;;
            "initial")
                select_array "Set the initial camera state: " STATE[@] config_vars[15]
                ;;
            "qp")
                read_number "Enter the Quantisation parameter. Use approximately 10-40. Default 0 (off): " config_vars[16]
                ;;
            "inline")
                select_array "Insert inline headers (SPS, PPS) to stream: " TRUTH[@] config_vars[17]
                ;;
            "segment")
                read_num "Segment output file in to multiple files at specified interval (ms): " config_vars[18]
                ;;
            "wrap")
                select_array "Insert inline headers (SPS, PPS) to stream: " TRUTH[@] config_vars[18]
                ;;
            "start")
                read_num "In segment mode, start with specified segment number: " config_vars[19]
                ;;
            "split")
                select_array "In wait mode, create new output file for each start event" TRUTH[@] config_vars[20]
                ;;
            "circular")
                select_array "Run encoded data through circular buffer until triggered then save: " TRUTH[@] config_vars[21] 
                ;;
            "vectors")
                read_filename "Output filename <filename> for inline motion vectors: " config_vars[22]
                ;;
            "camselect")
                read_num "Select camera <number>. Default 0 :" config_vars[23]
                ;;
            "mode")
                echo Mode: 0, Automatic
                echo Mode: 1, Size: 1920x1080,  Aspect Ratio: 16:9,  Frame rates: 1-30     fps,  FOV: Partial,  Binning: None
                echo Mode: 2, Size: 2592x1944,  Aspect Ratio: 4:3,   Frame rates: 1-15	   fps,  FOV: Full,	    Binning: None
                echo Mode: 3, Size: 2592x1944,  Aspect Ratio: 4:3,   Frame rates: 0.166-1  fps,  FOV: Full,	    Binning: None
                echo Mode: 4, Size: 1296x972,   Aspect Ratio: 4:3,   Frame rates: 1-42	   fps,  FOV: Full,	    Binning: 2x2
                echo Mode: 5, Size: 1296x730,   Aspect Ratio: 16:9,  Frame rates: 1-49	   fps,  FOV: Full,	    Binning: 2x2
                echo Mode: 6, Size: 640x480,    Aspect Ratio: 4:3,   Frame rates: 42.1-60  fps,  FOV: Full,	    Binning: 2x2 plus skip
                echo Mode: 7, Size: 640x480,    Aspect Ratio: 4:3,   Frame rates: 60.1-90  fps,  FOV: Full,	    Binning: 2x2 plus skip
                select_array "Choose mode: " MODE[@] config_vars[24]
                ;;
            "irefresh")
                select_array "Set intra refresh type :" REFRESH[@] config_vars[25]
                ;;
            "flush")
                select_array "Flush buffers to decrease latency: " TRUTH[@] config_vars[26]
                ;;
            "save-pts")
                select_array "Save Timestamps to file for mkvmerge :" TRUTH[@] config_vars[27]
                ;;			
            "codec")
                select_array "Specify the codec to use - H264 (default) or MJPEG: " CODEC[@] config_vars[28]            
                ;;
            "level")
                select_array "Specify H264 level to use for encoding: " LEVEL[@] config_vars[29]
                ;;
            "quit")
                echo writing config vars to file...
                write_vars_to_file config_vars[@] "config_vars" "Begin writing config variables" "End writing config variables"
                echo done... Goodbye
                break
                ;;
            *)
                echo invalid response
                ;;
        esac
    done
}

main
