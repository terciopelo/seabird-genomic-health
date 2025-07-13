for f in *_scaffolds/
do
echo ${f}
sbatch gerpcol.sh ${f}
sleep 10
done
