#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=scaffold_singleline
#SBATCH --mem 64G
#SBATCH --output=%x-%j.out
#SBATCH --time=02-00:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

for f in *_scaffolds/*.fa
do
awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' ${f} > ${f/.fa/.sfa} | \
rm ${f}
done
