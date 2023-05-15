set -e
t=80

export PATH=~/mambaforge/envs/python3/bin:/storage-01/poultrylab1/zhaoqiangsen/software/Winnowmap/bin:$PATH

ref=CAU_Silkie_chr1-30_Z.fasta

if [ ! -d ${ref}.meryl ];
then
        meryl count k=15 threads=$t output ${ref}.meryl $ref
        meryl print greater-than distinct=0.9998 ${ref}.meryl > ${ref}.repetitive_k15.txt
fi
if [ ! -f ${ref}.repetitive_k15.txt ];
then
        meryl print greater-than distinct=0.9998 ${ref}.meryl > ${ref}.repetitive_k15.txt
fi


for i in `ls *chr1-30_Z.fasta | grep -v CAU`;
do
        winnowmap -W ${ref}.repetitive_k15.txt -a -x asm20 --cs -r 2000 -k 15 -t $t $ref $i | samtools sort -@ $t -m 4G -o CAU_Silkie_${i%.*}.bam -
        samtools index CAU_Silkie_${i%.*}.bam
        svim-asm haploid CAU_Silkie_${i%.*} CAU_Silkie_${i%.*}.bam $ref
done

