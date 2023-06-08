#!/bin/bash

split --numeric-suffixes=10 -l 10 file_list.txt --additional-suffix=.fl 

ls -l1 x**.fl | wc -l > num_splits.txt
