#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=constrained_mutations
#SBATCH --mem 12G
#SBATCH --output=%x-%j.out
#SBATCH --time=00-04:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load vcftools

prefix="variants."
for f in *.vcf.gz
do
x=${f#$prefix}
awk 'BEGIN {OFS="\t"} {if($7>2)print$1,$2,$3}' ../${x/.vcf.gz/_CE.txt} > ./${x/.vcf.gz/_CE2.bed}
vcftools --gzvcf $f --bed ${x/.vcf.gz/_CE2.bed} --out ${x/.vcf.gz/_CE2} --recode --keep-INFO-all
done

