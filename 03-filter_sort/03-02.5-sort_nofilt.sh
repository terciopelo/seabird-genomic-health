#!/bin/bash
#SBATCH --array=10-13
#SBATCH --job-name=sort_bam_no_filt
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --mem 64G
#SBATCH -c 8
#SBATCH --time 8:30:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load samtools

SAMPLELIST="../01-trim_qc/x${SLURM_ARRAY_TASK_ID}.fl"

for SAMPLE in `cat $SAMPLELIST`; do

## Convert to bam file for storage (including all the mapped reads)
        # -F 4 means retain only mapped reads
        #samtools view -bS -F 4 ../02-alignment/${SAMPLE}_aligned.bam  > ./mapped/${SAMPLE}_mapped.bam
        ## Filter the mapped reads (to only retain reads with high mapping quality)
        # Filter bam files to remove poorly mapped reads (non-unique mappings and mappings with a quality score < 20)
        #samtools view -h -q 20 ./mapped/${SAMPLE}_mapped.bam | samtools view -buS - | 
	samtools sort -o ./sorted_nofilt/${SAMPLE}_sorted.bam ../02-alignment/${SAMPLE}_aligned.bam
        samtools index ./sorted_nofilt/${SAMPLE}_sorted.bam
done
