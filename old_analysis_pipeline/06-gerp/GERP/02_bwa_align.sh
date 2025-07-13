#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=bwa_align
#SBATCH --mem 64G
#SBATCH --cpus-per-task 16
#SBATCH --output=%x-%j.out
#SBATCH --time=01-00:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load bwa

for f in /home/ewootton/projects/rrg-shaferab/ewootton/genome_health/GERP_analysis/genomes/fastq/*.fq
do
bwa mem -t 16 mountain_goat.fasta ${f} > ${f/.fq/.sam}
done
