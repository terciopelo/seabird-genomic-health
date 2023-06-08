#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --array=10-17
#SBATCH --job-name=align_rt
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@queensu.ca
#SBATCH --mem 20G
#SBATCH -c 8
#SBATCH --time 8:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load bwa
module load samblaster
module load samtools

# $SLURM_ARRAY_TASK_ID is the id of the current script copy

SAMPLELIST="../01-trim_qc/x${SLURM_ARRAY_TASK_ID}.fl"

for SAMPLE in `cat $SAMPLELIST`; do

echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

bwa mem -t 8 ../ref_genome/ref_genome.fa ../01-trim_qc/${SAMPLE}_trimmed_R1.fastq.gz ../01-trim_qc/${SAMPLE}_trimmed_R2.fastq.gz | samblaster --removeDups | samtools view -h -b -@8 -o ./${SAMPLE}_aligned.bam

done
