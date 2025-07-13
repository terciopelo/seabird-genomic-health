#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=maf
#SBATCH --mem 12G
#SBATCH --time=0-01:00
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

#Load vcftools
module load vcftools

#Filter with MAF 5%
vcftools --vcf variants.vcf --maf 0.05 --recode --recode-INFO-all --out filtered

#Replace the unfiltered vcf
mv filtered.recode.vcf variants.vcf

#Gzip
gzip variants.vcf
