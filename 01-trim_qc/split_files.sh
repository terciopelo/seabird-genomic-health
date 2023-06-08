#!/bin/bash

split --numeric-suffixes=10 -l 10 file_list1.txt

num=`ls -l1 x* | wc -l`

echo $((num-1+10)) > num_splits.txt


