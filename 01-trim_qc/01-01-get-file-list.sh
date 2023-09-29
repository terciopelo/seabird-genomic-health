#!/bin/bash

#Local script, no need for slurm

# remove any aliasing that will alter the output of ls
#unalias ls

cd ../raw_reads/

# get just file names for fastqs, output to text
ls *.gz -1 > ../01-trim_qc/file_list.txt

# remove every second entry (paired end reads=pairs of files)
# use -i flag to edit file

cd ../01-trim_qc

sed -i -e n\;d file_list.txt

# remove file extension (.fastq.gz) and last three characters upstream (to get just file name, not _R1/_R2)
sed -i 's/\(.*\)............/\1/' file_list.txt

# also make directory for fastp reports
mkdir fastp_reports
