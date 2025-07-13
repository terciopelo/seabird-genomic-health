#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=sift_annotate
#SBATCH --mem 64G
#SBATCH --time=00-12:00
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module load java
java -jar SIFT4G_Annotator.jar -c -i dbSNP/variants.vcf.gz -d prediction_database -r annotated_output -t
