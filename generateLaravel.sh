#!/bin/bash
# i=0
# while read line
# do
#     array[ $i ]="$line"
#     (( i++ ))
# done < <(ls -ls)
#
# echo ${array[1]}

files=(*)
for item in ${files[*]}
do
    #Route::resource('withdraw', 'withdrawController');
    printf "%s\n" $item | cut -f 1 -d '.'
done
