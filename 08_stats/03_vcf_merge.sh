#!/bin/bash
#SBATCH --account=rrg-barrett
#SBATCH --job-name=vcf_merge
#SBATCH --mem 128G
#SBATCH --time=03-00:00
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load bcftools

# Merge the VCFs
bcftools merge filtered_nain.recode.vcf.gz filtered_pond_inlet.recode.vcf.gz filtered_postville.recode.vcf.gz filtered_qikiqtarjuaq.recode.vcf.gz -Ov -o BLGU_filtered_all.vcf
