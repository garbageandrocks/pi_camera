#!/bin/bash
#
# Simple function to select on an array and save the input

# inputs:  PS3 string, array, select variable
# outputs: select variable populated with value

TRUTH=("true" "false")

# function:     select_on_array
# description:  selects value based on array and stores selected value in a variable 
# input:        ps3_str, list, out_var
# output:       out_var

select_on_list()
{
  # label input params
  ps3_str=$1
  list=("${!2}")
  out_var=$3

  PS3=$ps3_str

  select val in ${list[@]}; 
  do
    for i in ${!list[@]}; do
      if [ $val == ${list[i]} ]; then
        eval "$out_var=$val"
        return
      fi
    done
  done
}

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
# function:     get_filename
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



main()
{
  prompt="Generic list select:"
  #select_on_list "$prompt" TRUTH[@] value
  #echo $value

  #read_number "Enter a number:" num_val
  #echo $num_val
  read_filename "Specify a file name:" filename
  echo $filename
}

main

