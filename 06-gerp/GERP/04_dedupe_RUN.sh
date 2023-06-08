#!/bin/bash
for f in $(ls *.sorted.bam | sed 's/.sorted.bam//' | sort -u)
do
echo ${f}
analysisdir=/home/ewootton/projects/rrg-shaferab/ewootton/genome_health/GERP/deer/bam_files/deduped
root=/home/ewootton/projects/rrg-shaferab/ewootton/genome_health/GERP/deer/bam_files/deduped
sbatch -o $analysisdir/${f}-%A.out $root/picard.sh ${f} ${analysisdir} ${root}
sleep 10
done
