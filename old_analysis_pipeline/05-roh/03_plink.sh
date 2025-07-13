#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=plink
#SBATCH --mem 24G
#SBATCH --time=0-01:00
#SBATCH --output=%x-%j.out

#Module load plink
module load nixpkgs/16.09
module load plink/1.9b_5.2-x86_64

#Run plink for each scaffold
for f in $(ls ref* | sed 's/.\{5\}$//'| sort -u)
do
echo ${f}
plink --tfile ${f} --homozyg-snp 50 --homozyg-kb 100 --homozyg-density 50 --homozyg-gap 1000 --homozyg-window-snp 50 --homozyg-window-het 3 --homozyg-window-missing 10 --homozyg-window-threshold 0.05 --allow-extra-chr --out ${f}
done

#Concatenate each .hom file into one txt file
cat ScXtcTc*.hom > roh_total.txt

#Sort all individuals together
sort roh_total.txt > roh_sorted.txt

#Check everything has worked so far
wc -l roh_sorted.txt
head roh_sorted.txt

#Isolate the columns of interest (individual and KB)
awk '{$2=$3=$4=$5=$6=$7=$8=$10=$11=$12=$13=""; print $0}' roh_sorted.txt > roh_sorted_indiv.txt

#Double check everything again
wc -l roh_sorted_indiv.txt
head roh_sorted_indiv.txt

#Remove all lines containing "FID"
sed -i '/FID/d' roh_sorted_indiv.txt
