#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --job-name=index_ref
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --mem 20G
#SBATCH -c 1
#SBATCH --time 2:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e


module load bwa

cd ../ref_genome

bwa index ref_genome.fa

module load samtools
module load picard

samtools faidx  ../ref_genome/ref_genome.fa

java -jar $EBROOTPICARD/picard.jar CreateSequenceDictionary -R ../ref_genome/ref_genome.fa
