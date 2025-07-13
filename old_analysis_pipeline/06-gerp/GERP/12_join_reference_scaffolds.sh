#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=scaffold_joining
#SBATCH --mem 12G
#SBATCH --output=%x-%j.out
#SBATCH --time=0-12:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

# Create a new directory for all multiple alignments
mkdir scaffold_alignments

# Concatenate all reference fastas into one multiple alignment per scaffold
find . -type f -path '*_scaffolds/*.sfa' \
    -exec sh -c 'for pathname do cat "$pathname" >>"scaffold_alignments/${pathname##*/}"; done' find-sh {} +

cd scaffold_alignments

# Replace .sfa extension with .aln
for f in *.sfa; do
    mv -- "$f" "${f%.sfa}.aln"
done
