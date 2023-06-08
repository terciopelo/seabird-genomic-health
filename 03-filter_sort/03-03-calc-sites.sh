#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --array=1-4
#SBATCH --job-name=get_sites
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@queensu.ca
#SBATCH --mem 20G
#SBATCH -c 8
#SBATCH --time 3:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load samtools
touch sites.txt

for file in $(ls -1 ./sorted/*.bam); do
echo -n "$file: " >> sites.txt
samtools view -H ${file} | grep -P '^@SQ' | cut -f 3 -d ':' | awk '{sum+=$1} END {print sum}' >> sites.txt
done
