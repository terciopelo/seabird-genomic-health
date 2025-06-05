#!/bin/bash
#SBATCH --array=10-11
#SBATCH --job-name=indel_realign_blgu
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --mem 40G
#SBATCH -c 1
#SBATCH --time 15:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e
#SBATCH -w cac035

#module load gatk/3.8

#module load java
#module load StdEnv/2020  
module load java/1.8.0_292
SAMPLELIST="../01-trim_qc/x${SLURM_ARRAY_TASK_ID}.fl"

for SAMPLE in `cat $SAMPLELIST`; do
        # use the RealignerTargetCreator to identify regions where realignment was needed

	# java -jar $EBROOTGATK/GenomeAnalysisTK.jar -T RealignerTargetCreator \
	java -jar ~/gatk3.8/GenomeAnalysisTK.jar -T RealignerTargetCreator -R ../ref_genome/ref_genome.fa -o ./sorted_nofilt/${SAMPLE}.intervals -I ./sorted_nofilt/${SAMPLE}_sorted.bam

        # use IndelRealigner to realign the regions found in the RealignerTargetCreator step
        #java -jar $EBROOTGATK/GenomeAnalysisTK.jar -T IndelRealigner \
        java -jar ~/gatk3.8/GenomeAnalysisTK.jar -T IndelRealigner -R ../ref_genome/ref_genome.fa -targetIntervals ./sorted_nofilt/${SAMPLE}.intervals -I ./sorted_nofilt/${SAMPLE}_sorted.bam -o ./sorted_nofilt/${SAMPLE}_realign.bam
done

