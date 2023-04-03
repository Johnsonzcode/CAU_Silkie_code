
bamToBed -i aligned/merged_nodups.txt > alignment.bed
sort -k 4 alignment.bed > tmp && mv tmp alignment.bed

python run_pipeline.py -a purged.fasta -l purged.fasta.fai -b alignment.bed -e GATC -o scaffolds
