#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --job-name=angsd_grid_murres
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --array=1-10
#SBATCH --mem 200G
#SBATCH -c 1
#SBATCH --time 24:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load angsd

SL="../04-map_filter_sort/region${SLURM_ARRAY_TASK_ID}.rf"
FOLD="angsd_output_reg${SLURM_ARRAY_TASK_ID}_plink"

# make directory for angsd output
mkdir $FOLD

# generate beagle files for PCA
#angsd -GL 2 -doGlf 2 -b bampath.txt -doMajorMinor 1 -SNP_pval 1e-6 -doMaf 1 -nThreads 1 -minMaf 0.01 -minInd 2 -doCheck 0 -rf $SL -out "${FOLD}/reg${SLURM_ARRAY_TASK_ID}_angsd"

angsd -bam bampath.txt -doPlink 2 -doGeno -4 -doPost 1 -nThreads 1 -minInd 2 -doCheck 0 -minMaf 0.01 -doMajorMinor 1 -GL 1 -doCounts 1 -doMaf 2 -postCutoff 0.95 -SNP_pval 1e-6 -uniqueonly 1 -remove_bads 1 -C 50 -baq 1 -ref ../refgenome/ref_genome.fa -rf $SL -out "${FOLD}/reg${SLURM_ARRAY_TASK_ID}_angsd"
