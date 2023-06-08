#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=remove-dups
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --time=0-04:00 # time (DD-HH:MM)

module load StdEnv/2016.4
module load picard
module load samtools
module load sambamba

echo ${1}
java -Xmx120G -jar $EBROOTPICARD/picard.jar MarkDuplicates \
INPUT=${2}/${1}.sorted.bam \
OUTPUT=${2}/${1}.deduped.bam \
USE_JDK_DEFLATER=true USE_JDK_INFLATER=true \
ASSUME_SORT_ORDER=coordinate \
REMOVE_DUPLICATES=true REMOVE_SEQUENCING_DUPLICATES=true \
METRICS_FILE=${2}/${1}.deduped.picard &&
${3}/sambamba-0.7.0-linux-static flagstat \
--nthreads=30 \
${2}/${1}.deduped.bam \
> ${2}/${1}.deduped.flagstat
#END
