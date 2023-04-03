##################coding RNA annoation###########################
######denove prediction
###AUGUSTUS
augustus --species=chicken silkie_mask.fa > silkie_augustus.gff
###braker
braker.pl --cores 48 --species=silkie --genome= silkie_mask.fa\
     --softmasking \
     --bam=/storage-02/poultrylab3/chicken_transcript/transcript/all.REF_Scaffold_split_1.bam  \
     --prot_aln=/storage-01/poultrylab1/yin/sunyunxiao/CAU_silky/silky_v2/chr3_12_21/gth/Scaffold_split_1.gth.gff --prg=gth --gth2traingenes \
     --gff3 \
     --useexisting

######transcript prediction
####reference genome
####mapped
tophat2 --output-dir ./ --read-mismatches 2--read-edit-dist 2--max-intron-length 5000000 --library-type fr-unstranded --num-threads 8 --GTF Ref_Genome/Genome.gtf --mate-inner-dist 40 Ref_Genome/Genome sample_1.fq sample_1.fq
####cufflinks
cufflinks -o ./ -p 6 -g Ref_Genome/Genome.gtf --library-type fr-unstranded -u -L $sample Tophat/$sample/accepted_hits.bam
####merge
cuffmerge -o ./Cuffmerge -g Ref_Genome/Genome.gtf  -p 6 assembly_GTF_list.txt

####no reference
##mapped
Trinity --genome_guided_bam rnaseq_alignments.csorted.bam --max_memory 50G  --genome_guided_max_intron 10000 --CPU 30
##Download the contaminated database and create a database of contaminated sequences
~/yin/software/anaconda3/envs/pasa/opt/pasa-2.4.1/bin/seqclean Trinity.fasta -v ~/yin/sunyunxiao/trinity/trinity_out_dir/UniVec
cp ../27_trinity_out_dir/alignassembly.config ./
##pasa
~/yin/software/anaconda3/envs/pasa/opt/pasa-2.4.1/Launch_PASA_pipeline.pl -c alignassembly.config -C -R -g ~/yin/sunyunxiao/CAU_silky/braker/Scaffold_36.fa -t Trinity.fasta.clean --ALIGNERS blat --CPU 60

######Homologous prediction
exonerate --model protein2genome --showvulgar no --showalignment no --showquerygff no --showtargetgff yes --ryo "AveragePercentIdentity: %pi\n" -c 20 ./all_bird_protein.fa ./cau_silkie.fa > silkie_protein.gff3

#####EVM Converted
## run EVM
for i in `cat list1`
do
./EVidenceModeler/evidence_modeler.pl --genome /${i}.fa \
                       --weights ./weights.txt \
                       --gene_predictions ./augustus/${i}.au.gff3 \
                       --protein_alignments ./EVM/protein/${i}.protein.gff3 \
                       --transcript_alignments ./transcript/${i}.trans.gff3 \
                       --min_intron_length 15\
                     > ${i}.evm.out

echo
echo
echo "*** Created EVM output file: ${i}.evm.out ***"


## convert output to GFF3 format
./EVidenceModeler/EvmUtils/EVM_to_GFF3.pl ${i}.evm.out ${i} > ${i}.evm.gff3
echo
echo
echo "*** Converted EVM output to GFF3 format: ${i}.evm.gff3 ***"

echo
echo "Done."

done


