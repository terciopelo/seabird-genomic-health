#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=scaffold_separation
#SBATCH --mem 24G
#SBATCH --time=00-02:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

mkdir ${1/.pileup/_scaffolds}
mv ${1} ${1/.pileup/_scaffolds}
cd ${1/.pileup/_scaffolds}

csplit -s -z ${1} '/>/' '{*}'
for i in xx* ; do \
  n=$(sed 's/>// ; s/ .*// ; 1q' "$i") ; \
  mv "$i" "$n.fa" ; \
 done

mv ${1} ../
