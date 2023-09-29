#!/bin/bash
#SBATCH --job-name=fastp_grid_murres
#SBATCH --account=def-vlf
#SBATCH --mail-type=ALL
#SBATCH --mail-user=11ckb5@queensu.ca
#SBATCH --array=10-17
#SBATCH --mem 20G
#SBATCH -c 8
#SBATCH --time 10:00:00
#SBATCH -o %x-%j.o
#SBATCH -e %x-%j.e

module load fastp

# one way to pass sample list = first passed parameter on command line
# SAMPLELIST=$1

# or, just set the file name directly
SAMPLELIST="./x${SLURM_ARRAY_TASK_ID}".fl

# loop through sample list
for SAMPLE in `cat $SAMPLELIST`; do
fastp --detect_adapter_for_pe --dedup --adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC --adapter_sequence_r2=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail -y -p -g -w 8 -i ../raw_reads/${SAMPLE}_R1.fastq.gz -I ../raw_reads/${SAMPLE}_R2.fastq.gz -o ./${SAMPLE}_trimmed_R1.fastq.gz -O ./${SAMPLE}_trimmed_R2.fastq.gz -h ./fastp_reports/${SAMPLE}.html
done


# filters/analyses done...
# --detect_adapter_for_pe = automatically try to detect adapters in addition to overlap analysis
# --dedup = deduplicate sequences
# --adapter_sequence (and adapter_sequence_r2) = check for sequences specified by Genome Quebec
# --cut_tail = run sliding window trimming from tail of sequence to head to remove low quality area
# -y = low complexity filter (default = 30%)
# -p  = over-representation analysis
# -g = remove polyG tails
# -w = threads 
# -i = input r1
# -I = input r2
# -o = output r1
# -O = output r2
# -h = path for html report
