blastn -db db/cau_silkie_name -query galgal4_genome_BAC_clone.fasta -out find_allfish_in_cau_silkie_name.out -outfmt "7 std qlen slen qcovs" -num_threads 40  -max_hsps 1 -qcov_hsp_perc 80 -perc_identity 90 -evalue 1e-5
awk '$2 ~ "chr"{print $1}' find_allfish_in_cau_silkie_name.out | xargs -I {} grep {} find_allfish_in_cau_silkie_name.out | awk '$2 ~ "Query"{print $4}' > blast1.out
awk '$2 ~ "chr"{print $0}' find_allfish_in_cau_silkie_name.out > blast.out
paste -d "\t" blast1.out blast.out > FISH_blast.out
for i in `seq 1 38` W Z;
do
echo "chr"$i; grep `echo "chr"$i` FISH_blast.out |wc -l;
done

