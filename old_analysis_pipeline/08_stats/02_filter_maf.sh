#!/bin/bash
#SBATCH --account=rrg-barrett
#SBATCH --job-name=maf
#SBATCH --mem 64G
#SBATCH --time=02-00:00
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load bcftools
module load vcftools

# Zip all vcf files
for f in *.vcf
do
bgzip $f
done

# Index all vcf files
for f in *.vcf.gz
do
bcftools index $f
done

# Filter with MAF 5%
for f in *.vcf.gz
do
vcftools --gzvcf $f --maf 0.05 --recode --recode-INFO-all --out ${f/BLGU/filtered}
done
