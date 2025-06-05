#!/bin/bash
#SBATCH --array=10-13
#SBATCH --job-name=depth_check_blgu
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --mem 32G
#SBATCH -c 1
#SBATCH --time 12:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load samtools

touch depths.txt

SAMPLELIST="../01-trim_qc/x${SLURM_ARRAY_TASK_ID}.fl"
for SAMPLE in `cat $SAMPLELIST`; do
	echo -n "$SAMPLE:" >> depths${SLURM_ARRAY_TASK_ID}.txt
	# get sites from sites.txt file, use to replace 1180976038
	samtools depth -a ./sorted_nofilt/${SAMPLE}_realign.bam |  awk '{sum+=$3} END { print "Average = ",sum/1197650647}' >> depths${SLURM_ARRAY_TASK_ID}.txt
done
