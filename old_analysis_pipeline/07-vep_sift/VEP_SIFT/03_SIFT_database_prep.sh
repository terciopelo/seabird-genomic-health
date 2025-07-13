#Acquire the necessary scripts to build a databse
git clone https://github.com/pauline-ng/SIFT4G_Create_Genomic_DB.git scripts_to_build_SIFT_db

#Make directories for all required files
mkdir files
mkdir files/gene-annotation-src
mkdir files/chr-src
mkdir files/dbSNP
mkdir files/protein_database

#Download and install gffread
git clone https://github.com/gpertea/gffread
cd gffread
make release

#Unzip gff file
gunzip -c sorted.gff.gz > sorted.gff

#Convert gff annotation to gtf
gffread sorted.gff -T -o annotations.gtf

#Gzip the gtf
gzip annotations.gtf

#Move to correct directory
mv annotations.gtf.gz sift/files/gene-annotation-src

#Gzip fasta
gzip sorted.fa

#Move to correct directory
mv sorted.fa.gz sift/files/chr-src/genome.fa.gz

#Download uniprot 90
wget https://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/uniref90.fasta.gz

#Move to correct directory
mv uniref90.fasta.gz sift/files/protein_database

#Unzip fasta
gunzip uniref90.fasta.gz

#Move vcf to correct directory
mv variant_effect_output.txt sift/files/dbSNP/variants.vcf

#Acquire and build sift4g
git clone --recursive https://github.com/rvaser/sift4g.git sift4g
cd sift4g/
make

#Ensure config.txt looks like this:

#GENETIC_CODE_TABLE=1
#GENETIC_CODE_TABLENAME=Standard
#MITO_GENETIC_CODE_TABLE=2
#MITO_GENETIC_CODE_TABLENAME=Vertebrate Mitochondrial

#PARENT_DIR=./files/
#ORG=rangifer_tarandus
#ORG_VERSION=prediction_database_CB
#DBSNP_VCF_FILE=variants.vcf.gz

##Running SIFT 4G
#SIFT4G_PATH=./sift4g/bin/sift4g
#PROTEIN_DB=./files/protein_database/uniref90.fa


## Sub-directories, don't need to change
#GENE_DOWNLOAD_DEST=gene-annotation-src
#CHR_DOWNLOAD_DEST=chr-src
#LOGFILE=Log.txt
#ZLOGFILE=Log2.txt
#FASTA_DIR=fasta
#SUBST_DIR=subst
#ALIGN_DIR=SIFT_alignments
#SIFT_SCORE_DIR=SIFT_predictions
#SINGLE_REC_BY_CHR_DIR=singleRecords
#SINGLE_REC_WITH_SIFTSCORE_DIR=singleRecords_with_scores
#DBSNP_DIR=dbSNP

## Doesn't need to change
#FASTA_LOG=fasta.log
#INVALID_LOG=invalid.log
#PEPTIDE_LOG=peptide.log
#ENS_PATTERN=ENS
#SINGLE_RECORD_PATTERN=:change:_aa1valid_dbsnp.singleRecord
