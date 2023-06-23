#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --job-name=plink_merge
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --mem 200G
#SBATCH -c 1
#SBATCH --time 10:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load StdEnv/2020
module load plink/1.9b_6.21-x86_64


plink --file angsd_output_reg1_plink --merge-list ped_list.txt --allow-extra-chr --noweb --out merged_plink
