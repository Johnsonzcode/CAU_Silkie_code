ref=GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_genomic.fa
qry=silkie_chr.fa
nucmer --mum -c 1000 -p 7b_vs_silkie -t 60 $ref $qry
delta-filter -i 90 -l 10000 -1 7b_vs_silkie.delta > 7b_vs_silkie.delta.filter
show-tiling -i 90 -l 10000 -v 0.01 -V 0.01 7b_vs_silkie.delta.filter > 7b_vs_silkie.delta.filter.tiling

