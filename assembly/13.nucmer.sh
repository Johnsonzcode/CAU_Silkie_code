#!/bin/sh
#PBS -N nucmer
#PBS -q batch
#PBS -V

set -e #stop anywhere but pipe

if [ $# -eq 0 ];then
        echo -e "\nUASGE:       qsub nucmer.sh -l nodes=1:ppn=threads,mem=memory -F "ref qry"\n"
        exit 0
fi

source "/home/Software/bioinformatics/anaconda3/etc/profile.d/conda.sh"
conda activate /storage-01/poultrylab1/yin/software/anaconda3/envs/asm_practise

cd $PBS_O_WORKDIR

q=$2
r=$1
t=`wc -l < $PBS_NODEFILE`

if [ ! -d ${1}_vs_${2} ];then
        mkdir ${1}_vs_${2}
fi

cd ${1}_vs_${2}

nucmer -p ${1}_vs_${2} -t $t -c 1000 ../$1 ../$2
delta-filter -1 -i 90 -l 10000 ${1}_vs_${2}.delta > ${1}_vs_${2}.deltafilter
show-tiling -i 90 -l 10000 -v 10 -V 0.01 ${1}_vs_${2}.deltafilter > ${1}_vs_${2}.tiling
mummerplot --fat --filter --png ${1}_vs_${2}.deltafilter -p ${1}_vs_${2}

