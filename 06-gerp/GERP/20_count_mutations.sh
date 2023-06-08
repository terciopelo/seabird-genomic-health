rm num_constrained_mutations.txt 
rm num_dis_constrained_mutations.txt
rm num_homo_dis_constrained_mutations.txt

# Find number of mutations
for f in *.recode.vcf
do
grep -v '^#' $f | grep -v '0/0' | wc -l >> num_constrained_mutations.txt
done

# Find number of disruptive mutations
for f in *.recode.vcf
do
grep -v '^#' $f | grep 'protein_altering_variant\|missense_variant\|inframe_deletion\|transcript_amplification\|start_lost\|stop_lost\|frameshift_variant\|stop_gained\|splice_donor_variant\|splice_acceptor_variant\|transcript_ablation' | grep -v '0/0' | wc -l >> num_dis_constrained_mutations.txt
done

# Find number of homozygous disruptive mutations
for f in *.recode.vcf
do
grep -v '^#' $f | grep 'protein_altering_variant\|missense_variant\|inframe_deletion\|transcript_amplification\|start_lost\|stop_lost\|frameshift_variant\|stop_gained\|splice_donor_variant\|splice_acceptor_variant\|transcript_ablation' | grep -v '0/0' | grep '1/1\|2/2\|3/3\|4/4\|5/5' | wc -l >> num_homo_dis_constrained_mutations.txt
done
