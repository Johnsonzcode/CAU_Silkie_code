##################RNA-seq pipeline###############################
####hisat2 mapped
hisat2 -p 4 -x silkie -1 ./SRR1822376.sra_1.fastq.gz -2 ./SRR1822376.sra_2.fastq.gz -S ./SRR1822376.sam
####sam →bam
samtools view -bS ./SRR1822376.sam > ./SRR1822376.bam
####sort
samtools sort -l 9 -m 2G -o ./SRR1822376_sort.bam -@ 30 ./SRR1822376.bam
##
/home/Software/bioinformatics/anaconda3/bin/htseq-count -s no  -r pos -f bam SRR1822376_sort.bam  silkie.gtf > SRR1822376.count
