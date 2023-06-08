#Load seqkit and samtools
module load seqkit
module load samtools

#Sort the gff file
(grep ^"#" rangifer_tarandus_QC.gff3; grep -v ^"#" rangifer_tarandus_QC.gff3 | sort -k1,1 -k4,4n) > sorted.gff

#Compress and index the gff file
bgzip sorted.gff
tabix -p gff sorted.gff.gz

#Sort the fasta file
seqkit sort rangifer_tarandus_QC.fa > sorted.fa

#Index the fasta file
samtools faidx sorted.fa

#Sort the vcf file
cat rangifer_tarandus_phased.vcf | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k2,2n"}' > sorted.vcf 
