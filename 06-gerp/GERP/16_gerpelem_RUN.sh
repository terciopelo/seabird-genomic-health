for f in *_scaffolds/
do
echo ${f}
sbatch gerpelem.sh ${f}
sleep 10
done
