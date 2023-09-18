#!/bin/bash
#SBATCH --account=rrg-barrett
#SBATCH --job-name=tajima_pi
#SBATCH --mem 64G
#SBATCH --time=0-12:00
#SBATCH --output=%x-%j.out

module load vcftools

# Loop through each population's sample list
for pop_file in *_pop.txt; do
    
    # Deduce the population name by removing the '_pop.txt' suffix
    pop_name=${pop_file%_pop.txt}
    
    # Calculate Tajima's D
    vcftools --vcf BLGU_filtered_all.vcf --keep $pop_file --TajimaD 10000 --out ${pop_name}_TajimaD
    
    # Calculate Pi (nucleotide diversity)
    vcftools --vcf BLGU_filtered_all.vcf --keep $pop_file --window-pi 10000 --out ${pop_name}_pi
    
done
