#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=htsbox
#SBATCH --mem 64G
#SBATCH --output=%x-%j.out
#SBATCH --time=0-06:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

cat bam.list | while read line
do
./htsbox/htsbox pileup -f /home/ewootton/projects/rrg-shaferab/MAMMAL_GENOMES/odocoileus_virginianus_FILES/wtd_genome.fasta \
-Q20 -q30 -Fs3 ${line} > ./${line/.deduped.bam/.pileup}
done
