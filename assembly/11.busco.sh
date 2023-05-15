#!/bin/sh
#PBS -N busco
#PBS -q batch
#PBS -V

set -e #stop anywhere but pipe


source "/home/Software/bioinformatics/anaconda3/etc/profile.d/conda.sh"
conda activate /storage-01/poultrylab1/yin/software/anaconda3/envs/asm_assessment

cd $PBS_O_WORKDIR

q=$2
r=$1
t=`wc -l < $PBS_NODEFILE`

if [ ! -d ${1}_busco ];then
        mkdir ${1}_busco
fi

cd ${1}_busco

busco -f -i ../$1 -l ~/zhaoqiangsen/GenomeAssembly/aves_odb10 -o ${1%.*} -m genome --cpu $t
