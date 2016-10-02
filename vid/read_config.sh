#!/bin/bash
#
# Methods for reading config from file and executing raspivid

TAGS=("-w" "-h" "-b" "-o" "-v" "-t" "-d" "-fps" "-e" "-g" "-pf" "-td" "-s" "-k" "-i" "-qp" "-ih" "-sg" "-wr" "-sn" "-sp" "-c" "-x" "-cs" "-set" "-md" "-if" "-fl" "-pts" "-cd" "-lev")
CONFIG_VARS=()
CMD="raspivid"

read_file_into_global_array()
{
    filename=$1
    i=0

    while IFS='' read -r line || [[ -n "$line" ]]
    do
        CONFIG_VARS[i]=$line
        let i=i+1        
    done < "$filename"
}

create_raspivid_str()
{
    space=" "
    for i in ${!TAGS[@]};
    do
        if [[ ! "blank" == ${CONFIG_VARS[i]} ]]; then
            CMD=$space$CMD$space${TAGS[i]}$space${CONFIG_VARS[i]}
        fi
    done
}
main()
{
    read_file_into_global_array config_vars.txt
#    for i in ${!CONFIG_VARS[@]};
#        do
#            echo ${CONFIG_VARS[i]}
#        done
    create_raspivid_str
    echo $CMD
    $CMD
}

main
