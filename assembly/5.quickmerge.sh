#!/bin/sh
#PBS -l nodes=1:ppn=100
#PBS -N quick_merge
#PBS -q batch
#PBS -l mem=200G

cd $PBS_O_WORKDIR
source /home/Software/bioinformatics/anaconda3/bin/activate
conda activate /storage-01/poultrylab1/yin/software/anaconda3/envs/quickmerge

./merge_wrapper.py ont_genome.nextpolish.fa chicken_hifi_3cell_asm.p_ctg.fa -l 10000 -v -t 100
./merge_wrapper.py chicken_hifi_3cell_asm.p_ctg.fa ont_genome.nextpolish.fa -l 10000 -v -t 100
./merge_wrapper.py hifi_as_query/merged_out.fasta hifi_as_ref/merged_out.fasta -l 10000 -v -t 100 
