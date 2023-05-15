#!/bin/bash

source /home/Software/bioinformatics/anaconda3/bin/activate
conda activate /storage-01/poultrylab1/yin/software/anaconda3/envs/asm_practise

./NextDenovo/nextDenovo run.cfg
