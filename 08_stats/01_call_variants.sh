#!/bin/bash
#SBATCH --account=rrg-barrett
#SBATCH --job-name=bam2vcf_nain
#SBATCH --mem-per-cpu=32G
#SBATCH --cpus-per-task 10
#SBATCH --time=07-00:00
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load bcftools

bcftools mpileup -Ou -f /home/ewootton/scratch/reference/BLGU_genome.fa -b /home/ewootton/scratch/BLGU_bams/nain/bam_list.txt | \
bcftools call -mv -Ov -o BLGU_nain.vcf --threads 10
