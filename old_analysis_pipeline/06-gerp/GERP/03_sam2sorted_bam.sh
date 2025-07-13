#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=sam2bam
#SBATCH --mem 64G
#SBATCH --cpus-per-task 10
#SBATCH --output=%x-%j.out
#SBATCH --time=0-06:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load samtools

for f in *.sam
do
samtools view -F 256 -F 4 -q 1 -@ 10 -S -b ${f} > ${f/.sam/.bam}
done

for f in *.bam
do
samtools sort -@ 4 ${f} -o ${f/.bam/.sorted.bam}
done
