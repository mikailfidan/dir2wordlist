#!/bin/bash

# Colors
COLOR_RED=$'\e[31m'
COLOR_CYAN=$'\e[36m'
COLOR_YELLOW=$'\e[33m'
COLOR_GREEN=$'\e[32m'
COLOR_RESET=$'\e[0m'
FONT_BOLD=$"\e[331m"
FONT_RESET=$"\e[330m"
 
usage () {
    echo ""
    echo "${COLOR_CYAN} ./dir2wordlist.sh [OPTIONS] ${COLOR_RESET}"
    echo ""
    echo " Options:"
    echo ""
    echo "  -d, required Target directory."
    echo ""
    echo "  -e, optional Exclude extensions.The extensions must be in quotes and separated by spacess."
    echo "      (Exp: -e \"png jpg css js\")"
    echo ""
    echo "  -o, optional Output file name.(Default:date-hourse-minute_wordlist.txt)"
    echo ""
    echo " For Example: ${COLOR_CYAN}./dir2wordlist.sh -d /home/script-folder -e \"png jpg css js\" -o dir_wordlist.txt ${COLOR_RESET}"
    echo""
    exit; 	
}


print_header () {
  echo  "         _"
  echo  "  _| o ._ )       _  ._ _| | o  _ _|_" 
  echo  " (_| | | /_ \/\/ (_) | (_| | | _>  |_" 
  echo "  github.com/mikailfidan       ver 1.0" 
  printf "\055%.s" {1..53}
  printf "\n   Target Directory	|%.0s  $dir \n"
  printf "   Extension Filters	|%.0s  $exclude_extensions\n" 
  printf "   Output File     	|%.0s  $output_file\n"  
  printf "\055%.s" {1..53} 
 echo ""
}


while getopts ":d:e:o:h:" opt; do
   case $opt in
         d)
            dir=$(echo $OPTARG | sed -e 's/\/$//g') >&2
           ;;
         e)
           exclude_extensions=$(echo $OPTARG | sed -e 's/^/*./' -e 's/ /|*./g') >&2
          ;;
         o)
	   output_file=$OPTARG >&2
	   ;;
        h) usage
	  ;; 
        *)
           usage
           ;;
   esac
done

if [ -z $output_file ]; then
    output_file=$(date +"%y-%m-%dT%H-%M")_wordlist.txt
fi

if [ -z $dir ]; then
     echo""
     echo " ${COLOR_RED}-d paramater is required ${COLOR_RESET}"
     echo""
     usage
else
    if [ -z $exclude_extensions ]; then
         print_header
         find $dir | awk -F$dir '{print $2}' | sed -e 's/\///' | tee $output_file | while read item; do
	   echo -ne " => $item%\033[0K\r"
  	   sleep 0.00001
	 done

    else
	print_header
        find $dir | awk -F$dir '{print $2}' | sed -e 's/\///'| grep -E -v "$exclude_extensions" | tee $output_file |  while read item; do
          echo -ne " => $item%\033[0K\r"
          sleep 0.00001
        done

    fi
fi

printf "\055%.0s" {1..53}
echo""
echo -e "${COLOR_GREEN} + The wordlist saved as \033[1m$output_file\033[0m ${COLOR_RESET}"
echo -e "${COLOR_GREEN} + The number of lines is \033[1m$(cat $output_file | wc -l)\033[0m ${COLOR_RESET}"
printf "\055%.0s" {1..53}
echo ""
