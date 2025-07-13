#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=plink_prune
#SBATCH --mem 6G
#SBATCH --time=0-01:00
#SBATCH --output=%x-%j.out

#Module load plink
module load nixpkgs/16.09
module load plink/1.9b_5.2-x86_64

#Concatenate all tpeds that are > 10MB
cat *.tped >> plinkinput_filtered.tped

#Copy a random tfam to plinkinput_filtered.tfam
cp ScXtcTc_1029.tfam > plinkinput_filtered.tfam

#Calculate f-statistics
plink --tfile plinkinput_filtered --het --allow-extra-chr --maf 0.05
