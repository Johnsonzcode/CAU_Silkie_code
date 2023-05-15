#!/bin/sh
#PBS -l nodes=1:ppn=150
#PBS -N fmlrc2
#PBS -q batch
#PBS -l mem=500G

cd $PBS_O_WORKDIR
source /home/Software/bioinformatics/anaconda3/bin/activate
conda activate /storage-01/poultrylab1/yin/software/anaconda3/envs/asm_practise

export PATH="/storage-01/poultrylab1/zhaoqiangsen/GenomeAssembly/mallard/0.ONT_practise/test/rust-fmlrc/target/release:$PATH"
ccs=chicken_hifi_3cell.fa.gz
SYWGJ=~/Genome/nanopore/genome/fq_gz/SYWGJ_ONT.fq.gz
ONT_all=Chicken_ONT_93X.fa.gz

# build msbwt
pigz -p 1 -d -c $ccs | awk 'NR % 4 == 2' | tr NT TN | ropebwt2 -LR | tr NT TN | fmlrc2-convert ./MSBWT/chicken_hifi_3cell_unsort.npy && echo "Build msbwt finished!"

pigz -p 150 -d $ONT_all

fmlrc2 -t 150 -m 3 -C 10 ./MSBWT/chicken_hifi_3cell_unsort.npy Chicken_ONT_93X.fa Chicken_ONT_93X_corrected.fa
