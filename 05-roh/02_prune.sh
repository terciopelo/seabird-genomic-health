#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=plink_prune
#SBATCH --mem 24G
#SBATCH --time=0-02:00
#SBATCH --output=%x-%j.out

module load nixpkgs/16.09
module load plink/1.9b_5.2-x86_64

#Prune out LD
plink --tfile plinkinput --indep-pairwise 50 10 0.1 --allow-extra-chr

#Make a bed file with pruned results
plink --tfile plinkinput --extract plink.prune.in --allow-extra-chr --make-bed --out pruneddata

#Convert bed to tped
plink --bfile pruneddata --recode tab transpose --allow-extra-chr --out pruneddata

#Create a list of scaffolds greater than 10MB
sort mountain_goat.fasta.fai -k 2 -V | awk '{if($2>10000000)print$1}' > seqs_to_keep.txt

#Separate pruneddata.tped into a separate file for each scaffold greater than 10MB
input="seqs_to_keep.txt"
while IFS= read -r line
do
  echo "$line" | awk 'match($0,/\y'$line'\y/)' pruneddata.tped > $line.tped
done < "$input"

#Separate pruneddata.tfam into a separate file for each scaffold greater than 10MB
input="seqs_to_keep.txt"
while IFS= read -r line
do
  cp pruneddata.tfam $line.tfam
done < "$input"
