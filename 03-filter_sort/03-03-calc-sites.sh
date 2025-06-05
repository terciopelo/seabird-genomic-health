#!/bin/bash
#SBATCH --job-name=get_sites_blgu
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --mem 20G
#SBATCH -c 8
#SBATCH --time 3:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load samtools
touch sites.txt
#pick a representative bam, put it here
file="./sorted_nofilt/HI.4767.004.BioOHT_33.BG-03_realign.bam"

samtools view -H ${file} | grep -P '^@SQ' | cut -f 3 -d ':' | awk '{sum+=$1} END {print sum}' >> sites.txt
