#!/bin/bash

ref1=CAU_Silkie.fa
ref2=GRCg7b.fa
speedseq var -o Silkie_var -t 100 $ref1 `ls *.bam`
speedseq var -o 7b_var -t 100 $ref2 `ls *.bam`

