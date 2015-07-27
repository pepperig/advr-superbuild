#!/bin/bash

actual_dir=`pwd`
# if the script is sourced add the trap
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && trap  "{ cd $actual_dir; trap - INT; return 1; }" INT

robots_dir="$ROBOTOLOGY_ROOT/robots"
external_dir="$ROBOTOLOGY_ROOT/external"

echo -e "\nROBOTOLOGY superbuild repo where you have to push your commits: \n"
suffix="/"

#robots dir for each
for f in `cd $robots_dir && ls -d -- */`
do
    cd "$robots_dir/$f"
    if  git status | grep -q push ;  then
	to_print=${f%$suffix} 
	echo -e "\e[32m$to_print \e[39m"	
    fi
    cd ..
done

#external dir for each
for f in `cd $external_dir && ls -d -- */`
do
    cd "$external_dir/$f"
    if  git status | grep -q push ;  then 
        to_print=${f%$suffix} 
	echo -e "\e[32m$to_print \e[39m"	
    fi
    cd ..
done

# come back to the dir where the script was executed
cd $actual_dir
# possibly remove trap
trap - INT