#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=rename
#SBATCH --mem 64G
#SBATCH --output=%x-%j.out
#SBATCH --time=00-12:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

for f in ./*_scaffolds/*.sfa
do
sed -i "1s/>.*/>Rangifer_tarandus/" ${f}
done
