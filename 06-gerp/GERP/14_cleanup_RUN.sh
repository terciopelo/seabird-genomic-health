for f in *_scaffolds/
do
echo ${f}
sbatch -o ${f}-%A.out cleanup.sh ${f}
sleep 10
done
