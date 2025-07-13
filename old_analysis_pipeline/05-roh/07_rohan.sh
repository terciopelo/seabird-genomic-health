#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=rohan
#SBATCH --mem 128G
#SBATCH --time=02-00:00
#SBATCH --cpus-per-task 10
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

#Identify all runs of homozygosity
./ROHan/src/rohan -o ${1/.bam/} -v -t 10 --size 100000 --tstv 2.25 --auto seqs_to_keep_num.txt mountain_goat_num.fasta ${1}
