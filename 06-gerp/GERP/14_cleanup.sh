#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=cleanup
#SBATCH --mem=48G
#SBATCH --cpus-per-task 8
#SBATCH --output=%x-%j.out
#SBATCH --time=0-04:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

# Replace N with - and ensure all sequences are on new lines
cd ${1}
for x in *.aln
do
sed 's/>/\n>/g' ${x} | sed '/^>/! s/N/-/gI' > ${x/.aln/.mfa}
done
