#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=split_vcf
#SBATCH --mem 48G
#SBATCH --output=%x-%j.out
#SBATCH --time=00-12:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load bcftools

for file in *.vcf*; do
  for sample in `bcftools query -l $file`; do
    bcftools view -Oz -s $sample -o ${file/.vcf*/.$sample.vcf.gz} $file
  done
done
