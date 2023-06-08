#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=scaffold_joining
#SBATCH --mem 12G
#SBATCH --output=%x-%j.out
#SBATCH --time=0-12:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

# Add individual scaffolds to multiple alignments
for f in ./individuals/*_scaffolds
do
    for s in ${f}/*.sfa
    do
        x=${s/.\/*\//.\/scaffold_alignments\/}
        cat ${s} ${x/.sfa/.aln} > ${s/.sfa/.aln}
    done
done
