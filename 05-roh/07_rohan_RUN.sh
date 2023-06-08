#Run rohan.sh for each individual
for f in /home/ewootton/projects/rrg-shaferab/ewootton/genome_health/realign/bam_files/numeric/*.bam
do
echo ${f}
sbatch -o ${f}-%A.out rohan.sh ${f}
sleep 10
done
