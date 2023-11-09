#!/bin/bash

module load samtools

## Note: bam file must be index and sorted
samtools idxstats ./sorted/NS.2135.004.IDT_i7_195---IDT_i5_195.RLKI_BOG_259_sorted_minq20.bam  > scaffold_names_for_split.tsv

module load python
module load scipy-stack
source ~/pybasic/bin/activate

python3 scaffold_split.py
