#!/bin/bash

#Local script, no need for slurm

# remove any aliasing that will alter the output of ls
#unalias ls

# get just file names for fastqs, output to text
ls ../raw_reads/*.gz -1 > file_list.txt

# remove every second entry (paired end reads=pairs of files)
# use -i flag to edit file

sed -i -e n\;d file_list.txt

# remove file extension (.fastq.gz) and last three characters upstream (to get just file name, not _R1/_R2)
sed -i 's/\(.*\)............/\1/' file_list.txt

# also make directory for fastp reports
mkdir fastp_reports
