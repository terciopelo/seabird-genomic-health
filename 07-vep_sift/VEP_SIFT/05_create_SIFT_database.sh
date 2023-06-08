#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=sift
#SBATCH --mem 64G
#SBATCH --time=01-00:00
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

module --force purge
module load StdEnv/2020 gcc htslib bioperl mariadb perl
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
cpanm Archive::Zip
cpanm DBI
cpanm DBD::mysql
cpanm IntervalTree
cpanm Alien
cpanm Bio::DB::HTS
cpanm Bio::DB::Fasta

perl make-SIFT-db-all.pl -config config.txt
