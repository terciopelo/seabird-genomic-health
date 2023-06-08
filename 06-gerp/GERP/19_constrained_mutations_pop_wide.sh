module load vcftools

cat *.bed | sort -k1,1 -k2,2n | uniq > pop_wide_mutations.bed

vcftools --gzvcf variants.vcf.gz --bed pop_wide_mutations.bed --recode --keep-INFO-all

grep -v '^#' out.recode.vcf | wc -l
