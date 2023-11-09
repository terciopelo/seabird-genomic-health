#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --array=10-17
#SBATCH --job-name=align_species
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@queensu.ca
#SBATCH --mem 20G
#SBATCH -c 8
#SBATCH --time 8:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load bwa
module load samblaster
module load samtools

# $SLURM_ARRAY_TASK_ID is the id of the current script copy

SAMPLELIST="../01-trim_qc/x${SLURM_ARRAY_TASK_ID}.fl"

for SAMPLE in `cat $SAMPLELIST`; do

	# generate read group info for gatk
	header=$(zcat ../01-trim_qc/${SAMPLE}_trimmed_R1.fastq.gz | head -n 1)
	id=$(echo $header | head -n 1 | cut -f 1-4 -d":" | sed 's/@//' | sed 's/:/_/g')
	sm=$(echo $header | head -n 1 | grep -Eo "[ATGCN]+$")

	echo "SLURM_ARRAY_TASK_ID: "${SLURM_ARRAY_TASK_ID} " Sample: " $SAMPLE 1>&2

	bwa mem -M -R $(echo "@RG\tID:$id\tSM:$id"_"$sm\tLB:$id"_"$sm\tPL:ILLUMINA") -t 16 ../ref_genome/ref_genome.fa ../01-trim_qc/${SAMPLE}_trimmed_R1.fastq.gz ../01-trim_qc/${SAMPLE}_trimmed_R2.fastq.gz | samtools view -h -b -@16 -o ./${SAMPLE}_aligned.bam

done
