#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=gerpcol
#SBATCH --mem 64G
#SBATCH --time=00-04:00
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

cd ${1}
for x in *.mfa
do
../GERP++/gerpcol -a -f ${x} -t ../caribou_tree.nwk -s 1 -e Rangifer_tarandus
done
