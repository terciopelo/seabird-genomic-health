#!/bin/bash
#SBATCH --account=def-vlf
#SBATCH --array=39
#SBATCH --job-name=indel_realign_kittiwakes
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --mem 20G
#SBATCH -c 1
#SBATCH --time 16:30:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load nixpkgs/16.09
module load gatk/3.8

SAMPLELIST="../01-trim_qc/x${SLURM_ARRAY_TASK_ID}.fl"

for SAMPLE in `cat $SAMPLELIST`; do

        # use the RealignerTargetCreator to identify regions where realignment was needed
        java -jar $EBROOTGATK/GenomeAnalysisTK.jar -T RealignerTargetCreator \
        -R ../ref_genome/ref_genome.fa \
        -o ./sorted/${SAMPLE}.intervals \
        -I ./sorted/${SAMPLE}_sorted_minq20.bam

        # use IndelRealigner to realign the regions found in the RealignerTargetCreator step
        java -jar $EBROOTGATK/GenomeAnalysisTK.jar -T IndelRealigner \
        -R ../ref_genome/ref_genome.fa \
        -targetIntervals ./sorted/${SAMPLE}.intervals \
        -I ./sorted/${SAMPLE}_sorted_minq20.bam \
        -o ./sorted/${SAMPLE}_realign.bam
done

