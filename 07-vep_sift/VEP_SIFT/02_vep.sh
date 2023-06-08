#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=vep
#SBATCH --mem 24G
#SBATCH --time=00-06:00
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

#Load bioperl
module load bioperl

#Run VEP
./ensembl-vep/vep -i sorted.vcf --gff sorted.gff.gz --fasta sorted.fa --vcf --force_overwrite
