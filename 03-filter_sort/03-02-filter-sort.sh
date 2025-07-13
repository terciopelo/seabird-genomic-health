#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --array=10-17
#SBATCH --job-name=map_filt
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@queensu.ca
#SBATCH --mem 20G
#SBATCH -c 8
#SBATCH --time 8:30:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load samtools

SAMPLELIST="../01-trim_qc/x${SLURM_ARRAY_TASK_ID}.fl"

for SAMPLE in `cat $SAMPLELIST`; do

## Convert to bam file for storage (including all the mapped reads)
        # -F 4 means retain only mapped reads, retain only reads with quality >20
        samtools view -h -bS -F 4 -q20 ../02-alignment/${SAMPLE}_aligned.bam | samtools view -buS - | samtools sort -o ./sorted/${SAMPLE}_sorted_minq20.bam

        samtools index ./sorted/${SAMPLE}_sorted_minq20.bam
done
