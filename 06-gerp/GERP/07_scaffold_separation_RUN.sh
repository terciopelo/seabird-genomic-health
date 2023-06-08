for f in *_filtered.pileup
do
echo ${f}
sbatch -o ${f}-%A.out scaffold_separation.sh ${f}
sleep 10
done
