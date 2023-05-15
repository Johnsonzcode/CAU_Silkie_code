#!/bin/sh
#PBS -l nodes=1:ppn=100
#PBS -N extract_ccs
#PBS -q batch
#PBS -l mem=128G


cd $PBS_O_WORKDIR
source /home/Software/bioinformatics/anaconda3/bin/activate
conda activate /storage-01/poultrylab1/yin/software/anaconda3/envs/pb-hifi


cd $SLURM_SUBMIT_DIR

# merge 3 cell
pbmerge -o /storage-04/HIFI/Chicken/Chicken_hifi_ccs_r64061.bam /storage-04/HIFI/Chicken_hifi_ccs_*.bam

parallel "ccs /storage-04/HIFI/Chicken/Chicken_hifi_ccs_r64061.bam /storage-04/HIFI/Chicken_hifi_ccs_{}.bam --chunk {}/20 -j 5" ::: `seq 1 20`
