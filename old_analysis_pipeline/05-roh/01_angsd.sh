#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=angsd
#SBATCH --mem 256G
#SBATCH --cpus-per-task 16
#SBATCH --time=06-00:00
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load angsd

#Create the input for plink using angsd
angsd -bam bam.list -out plinkinput -doPlink 2 -doGeno -4 -doPost 1 -doMajorMinor 1 -GL 1 -doCounts 1 -doMaf 2 -postCutoff 0.95 -SNP_pval 1e-6 -uniqueonly 1 -nThreads 16 -remove_bads 1 -C 50 -baq 1 -ref /home/ewootton/projects/rrg-shaferab/ewootton/genome_health/mountain_goat.fasta
