#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --job-name=plink_transpose_guille
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --mem 40G
#SBATCH -c 1
#SBATCH --time 10:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load StdEnv/2020
module load plink/1.9b_6.21-x86_64


for ITER in {1..10}; do
        plink --tfile plink_output_reg${ITER}/reg${ITER}_plink --recode --allow-extra-chr --noweb --out plink_output_reg${ITER}/plink_reg${ITER}
done
