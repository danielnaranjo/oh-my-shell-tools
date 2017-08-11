#!/usr/bin/env bash
FOLDERS=( "C:/Users/inacayal1/Documents/GitHub/" "C:/MAMP/htdocs/" "D:/Daniel")

clear
echo "******************************"
echo "* "
for file in "${FOLDERS[@]}"
do
    echo "* $file will be removed from disk"
    echo "* "
    rm -rf $file
	echo "* $file removed"
    echo "* "
done

echo "* "
echo "******************************"
clear
