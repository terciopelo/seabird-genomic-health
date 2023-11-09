#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --job-name=get_sites_species
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@queensu.ca
#SBATCH --mem 20G
#SBATCH -c 8
#SBATCH --time 3:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load samtools
touch sites.txt
#pick a representative bam, put it here
file="representative_sorted.bam"

samtools view -H ${file} | grep -P '^@SQ' | cut -f 3 -d ':' | awk '{sum+=$1} END {print sum}' >> sites.txt
