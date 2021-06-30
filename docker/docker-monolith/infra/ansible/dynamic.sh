#!/bin/bash
####################################
##       List of arguments        ##
## $1 = --environment             ##
## $2 = <stage/prod>              ##
## $3 = --list or --host          ##
## $4 = if --host then <hostname> ##
####################################

echo "[reddit]" > environments/$2/inventory
#Poisk external ips i sortirovka
yc compute instance list | grep "reddit-app" | awk '{ print $4, "ansible_host="$10}' | sort >> environments/$2/inventory

if [ "$1" == "--environment" ]; then

  if [ "$2" == "stage" ]; then

    if [ "$3" == "--host" ]; then
      if [ "$4" == "reddit" ]; then
        count=$(sed -n '/[reddit]/,/ /p' environments/$2/inventory | wc -l)
        count=$(($count-1))
        cat environments/$2/inventory | grep --after-context=$count "\[reddit\]" 
      fi

    fi

    if [ "$3" == "--list" ]; then
      cat environments/$2/inventory
    fi
  fi

  if [ "$2" == "prod" ]; then

    if [ "$3" == "--host" ]; then
      if [ "$4" == "reddit" ]; then
        count=$(sed -n '/[reddit]/,/ /p' environments/$2/inventory | wc -l)
        count=$(($count-2))
        cat environments/$1/inventory | grep --after-context=$count "\[reddit\]" 
      fi
    fi

    if [ "$3" == "--list" ]; then
      cat environments/$2/inventory
    fi
  fi
fi