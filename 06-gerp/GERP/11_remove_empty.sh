#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=remove_empty
#SBATCH --mem 24G
#SBATCH --output=%x-%j.out
#SBATCH --time=00-06:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

# Delete all empty files
find . -type f -empty -print -delete
