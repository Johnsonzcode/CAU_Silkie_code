#############noncoding RNA annoation###########################
######tRNA annotation
tRNAscan-SE -o tRNA.out -f rRNA.ss -m tRNA.stats cau_silkie_chicken.fasta
######miRNA snRNA rRNA annotation
###download Rfam data
wget ftp://ftp.ebi.ac.uk/pub/databases/Rfam/CURRENT/Rfam.cm.gz
gzip  -d Rfam.cm.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/Rfam/CURRENT/Rfam.clanin
### cmpress index
cmpress Rfam.cm
##Z value
genome_total=1080553668（bp）#genome sequence size
CMnumber= grep "ACC" /database/Rfam/Rfam.cm | wc -l
8140
Z=`echo $genome_total*2*$CMnumber/1000000 | bc`
echo $Z
1080553668*2*8140
Z=17591413
##cmscan
cmscan -Z 18635991 --cut_ga --rfam --nohmmonly --tblout genome.tblout  \
  --fmt 2 --cpu 30 --clanin ./Rfam.clanin \
 ./Rfam.cm ~/yin/sunyunxiao/CAU_silky/silky_v2/gff_v2/cau > genome.cmscan
