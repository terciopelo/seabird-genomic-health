#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=filter_pileup
#SBATCH --mem 16G
#SBATCH --output=%x-%j.out
#SBATCH --time=00-04:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load seqkit

for f in *.pileup 
do
seqkit seq -m 10000 ${f} > ${f/.pileup/_filtered.pileup}
done
