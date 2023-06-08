#!/bin/bash

#These are all basic commands that can be typed directly into the command line

#Calculate the total length of all the scaffolds greater than 10MB
sort mountain_goat.fasta.fai -k 2 -V | awk '{if($2>10000000)print$1,$2}' > scaffold_lengths.txt
awk '{s+=$2}END{print s}' scaffold_lengths.txt

#Load R
module load r
R

#Create a table with %ROH per individual (35 individuals, total length of scaffolds used: 2433697063 bp)
all_roh <- read.table("roh_sorted_indiv.txt", quote="\"", comment.char="")
df_roh<-NULL
for(i in 1:35) {
temp=subset(all_roh, V1==i)
ind_roh<-cbind(i,(sum(temp$V2)*1000)/2433697063)
df_roh<-rbind(df_roh,ind_roh)
}
write.table(df_roh, file = "df_roh")

#Display the table
df_roh

#Quit R
quit()

#Label each %ROH with individual IDs
awk 'NR>1 {$3=$3*100;print$3}' df_roh > percent_temp

basename -a -s .realigned.bam /home/ewootton/projects/rrg-shaferab/ewootton/genome_health/realign/bam_files/*.realigned.bam > name_temp

paste -d " " name_temp percent_temp > percent_roh.txt

#Remove temporary files
rm percent_temp
rm name_temp
rm df_roh

#Calculate the average number of runs for ALL scaffolds
awk '{ total += $4; count++ } END { print total/count }' *.hom.indiv

#Calculate the average number of runs of homozygosity PER scaffold
for f in *.hom.indiv
do
awk '{ total += $4; count++ } END { print total/count }' ${f} >> num_runs_temp
done

#Calculate the average ROH length per scaffold
for f in *.hom.indiv
do
awk '{ total += $5; count++ } END { print 1000*total/count }' ${f} >> len_runs_temp
done

#Calculate percent ROH per scaffold
paste scaffold_lengths.txt len_runs_temp | awk '{print($3/$2)*100}' > per_runs_temp

#Create a summary table
paste -d " " scaffold_lengths.txt num_runs_temp len_runs_temp per_runs_temp > roh_summary.txt 

#Remove temporary files
rm num_runs_temp
rm len_runs_temp
rm per_runs_temp
