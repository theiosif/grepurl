#!/bin/bash

bold=`tput bold`
normal=`tput sgr0`
underline=`tput smul`
nounderline=`tput rmul`

usage() {
  echo ""
  echo "Returns all hrefs matching ${underline}searchString${nounderline} from the source of ${underline}targetUrl${nounderline}."
  echo ""
  echo "${bold}USAGE${normal}"
  echo "    grepurl ${underline}targetUrl${nounderline} ${underline}searchString${nounderline}"
  echo ""  
  echo "${bold}ARGUMENTS${normal}:"
  echo "    ${underline}targetUrl${nounderline}        Full url of webpage to be searched"
  echo "    ${underline}serchString${nounderline}      Query string (perl syntax regex)"
  echo ""
  echo "${bold}OPTIONS${normal}:"
  echo "    ${bold}-h|--help${normal}        display this message"
  echo ""
  exit 0
}

fatal() {
    echo "${bold}ERROR${normal}: $*"
    echo "Use ${underline}-h${normal} or ${underline}--help${normal} for more info."
    exit 1
}

[ "$1" = -h ] || [ "$1" = --help ] || [ $# -eq 0 ]&& usage

[ $# -lt 1 ] && fatal "missing both parameters."
[ $# -lt 2 ] && fatal "missing one parameter."
[ $# -gt 2 ] && fatal "expecting exactly two paramters."

URL=$1
Q=$2

if [ -f $1 ]
then
  cat $1 | grep -Po 'href="\K.*?(?=")' | grep $2
else
  wget $1 -q -O - | grep -Po 'href="\K.*?(?=")' | grep $2
fi