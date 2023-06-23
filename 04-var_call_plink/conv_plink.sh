#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --job-name=plink_conv
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --mem 200G
#SBATCH -c 1
#SBATCH --time 1:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load StdEnv/2020
module load plink/1.9b_6.21-x86_64

for i in {1..10}; do

	FOLD="angsd_output_reg${i}_plink"

	plink --tfile ./${FOLD}/reg${i}_angsd --recode --allow-extra-chr --noweb --out ${FOLD}
done
