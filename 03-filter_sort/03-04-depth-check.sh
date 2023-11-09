#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --array=10-17
#SBATCH --job-name=depth_check_species
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@queensu.ca
#SBATCH --mem 20G
#SBATCH -c 8
#SBATCH --time 3:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load samtools

touch depths.txt

SAMPLELIST="../01-trim_qc/x${SLURM_ARRAY_TASK_ID}.fl"
for SAMPLE in `cat $SAMPLELIST`; do
echo -n "$SAMPLE:" >> depths.txt
# get sites from sites.txt file, use to replace 1180976038
samtools depth -a ./sorted/${SAMPLE}_sorted_minq20.bam |  awk '{sum+=$3} END { print "Average = ",sum/1180976038}' >> depths.txt
done
