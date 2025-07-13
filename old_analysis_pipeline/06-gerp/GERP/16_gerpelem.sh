#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=gerpelem
#SBATCH --mem 64G
#SBATCH --output=%x-%j.out
#SBATCH --time=00-06:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

cd ${1}
for x in *.rates
do
../GERP++/gerpelem -f ${x}
done

rm core.*
