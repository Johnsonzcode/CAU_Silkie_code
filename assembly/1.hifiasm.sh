#!/bin/sh
#PBS -N hifiasm
#PBS -q batch
#PBS -V

set -e #stop anywhere but pipe

if [ $# -eq 0 ];then
        echo -e "\nUSAGE:       qsub hifiasm.sh -l nodes=1:ppn=threads,mem=memory -F "reads outdir"\n"
        exit 0
fi

cd $PBS_O_WORKDIR

if [ ! -d $2 ];then
        mkdir $2
fi

cd $2
t=`wc -l < $PBS_NODEFILE`

~/zhaoqiangsen/software/hifiasm/hifiasm -e -o ${1/%.fasta} -t $t ../$1 --write-ec
