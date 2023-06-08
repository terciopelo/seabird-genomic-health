#!/bin/bash
#SBATCH --job-name=fastp_grid
#SBATCH --account=def-vlf
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --array=10-17
#SBATCH --mem 20G
#SBATCH -c 8
#SBATCH --time 3:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load fastp

# one way to pass sample list = first passed parameter on command line
# SAMPLELIST=$1

# or, just set the file name directly
SAMPLELIST="./x${SLURM_ARRAY_TASK_ID}".fl

# loop through sample list
for SAMPLE in `cat $SAMPLELIST`; do
fastp -g -w 8 -i ../raw_reads/${SAMPLE}_R1.fastq.gz -I ../raw_reads/${SAMPLE}_R2.fastq.gz -o ./${SAMPLE}_trimmed_R1.fastq.gz -O ./${SAMPLE}_trimmed_R2.fastq.gz -h ./fastp_reps/${SAMPLE}.html
done
