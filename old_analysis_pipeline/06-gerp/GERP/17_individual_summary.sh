#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=individual_summary
#SBATCH --mem 4G
#SBATCH --output=%x-%j.out
#SBATCH --time=00-01:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

# Concatenate all CE files into one per individual
# Add a column for CE length (6) and a column for average RS score (7)
# Column 4 is the total RS score

for dir in *_scaffolds/
do
NAME=${dir/_filtered_scaffolds\//_CE}
cd $dir
        for f in *.elems
        do
        sed "s|region|${f/.mfa.rates.elems/}|g" $f > ${f/.mfa.rates.elems/.temp}
        done
cat *.temp | awk 'BEGIN {OFS="\t"} {print$1,$2,$3,$4,$5}' | \
awk 'BEGIN {OFS="\t"} {$6=$3-$2} 1' | \
awk 'BEGIN {OFS="\t"} {$7=$4/$6} 1' | \
sort -k1,1 -k2,2n > $NAME.txt
rm *.temp
mv *_CE.txt ..
cd ..
echo $NAME
done

rm -r summary_stats
mkdir summary_stats

# Calculate the average sum of element RS scores per individual
for f in *_CE.txt
do
awk '{ total += $4; count++ } END { print total/count }' ${f} >> avg_total_RS.txt
done

# Calculate the average CE length per individual
for f in *_CE.txt
do
awk '{ total += $6; count++ } END { print total/count }' ${f} >> avg_length.txt
done

# Calculate the average CE RS score per individual
for f in *_CE.txt
do
awk '{ total += $7; count++ } END { print total/count }' ${f} >> avg_RS.txt
done

mv avg*.txt summary_stats

# Calculat the total number of CEs per individual
for f in *_CE.txt
do
wc -l ${f} | awk '{print $1}' >> num_elements.txt
done

# Calculate the number of average CE RS scores lower than 2 per individual
for f in *_CE.txt
do
awk '$7<2{c++} END{print c+0}' ${f} >> num_2-.txt
done

# Calculate the number of average CE RS scores greater than 2 per individual
for f in *_CE.txt
do
awk '$7>2{c++} END{print c+0}' ${f} >> num_2+.txt
done

# Calculate the number of average CE RS scores greater than 3 per individual
for f in *_CE.txt
do
awk '$7>3{c++} END{print c+0}' ${f} >> num_3+.txt
done

mv num*.txt summary_stats
