#!/bin/sh
#PBS -l nodes=1:ppn=40
#PBS -N purge_dups
#PBS -q batch
#PBS -l mem=200G

# https://www.jianshu.com/p/e218a1192d12
cd $PBS_O_WORKDIR
source /home/Software/bioinformatics/anaconda3/bin/activate
conda activate /storage-01/poultrylab1/yin/software/anaconda3/envs/asm_practise

asm4=default/manual_bed.purged.fa

ccs=chicken_hifi_3cell.fa.gz
ont=Chicken_ONT_93X.fa

# 1 pb reads were mapped to asm and get cutoffs
minimap2 -t 80 -x map-pb $asm1 $ccs | pigz -p 80 -c - > pb_aln1.paf.gz
minimap2 -t 80 -x map-ont $asm1 $ont | pigz -p 80 -c - > ont_aln1.paf.gz
purge_dups/bin/pbcstat *1.paf.gz
purge_dups/bin/calcuts PB.stat > cutoffs 2>calcuts.log

# 2 check cut-offs
~/zhaoqiangsen/software/purge_dups-1.2.6/scripts/hist_plot.py -c cutoffs PB.stat PB.stat.png

# 3 set cut off
# ~/zhaoqiangsen/software/purge_dups-1.2.6/bin/calcuts -l 18 -u 309 -m 93 PB.stat > cutoffs

# 4 split asm by cutting N and self-alignment
purge_dups/bin/split_fa $asm > asm.split
minimap2 -t 100 -x asm5 -DP asm.split asm.split | pigz -p 100 -c > asm.split.self.paf.gz

# 5 classify contig by mapping info and self-alignment info
purge_dups/bin/purge_dups -2 -T cutoffs -c PB.base.cov asm.split.self.paf.gz > dups.bed 2> purge_dups.log
# cutoffs set : https://github.com/dfguan/purge_dups/issues/14
# last is l8 m89 h 280

# edit bed file

# 6 extract primary contigs
purge_dups/bin/get_seqs dups.bed $asm

# BUSCO to test
