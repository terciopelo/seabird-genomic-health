#!/bin/bash
#SBATCH --job-name=vcf_grid_blgu
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --array=10-13
#SBATCH --mem 64G
#SBATCH -c 1
#SBATCH --time 48:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load bcftools

#SL="../03-filter_sort/region${SLURM_ARRAY_TASK_ID}.rf"
#FOLD="plink_output_reg${SLURM_ARRAY_TASK_ID}"

SPLIT_FILE="../01-trim_qc/x"${SLURM_ARRAY_TASK_ID}".fl"

for FILE in `cat ${SPLIT_FILE}`; do
	bcftools mpileup -O u -f ../ref_genome/ref_genome.fa ../03-filter_sort/sorted_nofilt/${FILE}_realign.bam | bcftools call -c -o ${FILE}.vcf.gz -O z
done

# make directory for angsd output
#mkdir $FOLD

# generate beagle files for PCA
#angsd -bam bampath.txt -doPlink 2 -doGeno -4 -doPost 1 -nThreads 1 -minInd 2 -doCheck 0 -minMaf 0.01 -doMajorMinor 1 -GL 1 -doCounts 1 -doMaf 2 -postCutoff 0.95 -SNP_pval 1e-6 -uniqueonly 1 -remove_bads 1 -C 50 -baq 1 -ref ../refgenome/ref_genome.fa -rf $SL -out "${FOLD}/reg${SLURM_ARRAY_TASK_ID}_plink"
