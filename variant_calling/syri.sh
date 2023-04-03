cwd="."     # Change to working directory
PATH_TO_SYRI="/storage-01/poultrylab1/zhaoqiangsen/software/syri_1.4.1/syri/syri/bin/syri" #Change the path to point to syri executable
PATH_TO_PLOTSR="/storage-01/poultrylab1/zhaoqiangsen/software/plotsr-master/bin/plotsr" #Change the path to point to plotsr executable

cd $cwd
ref=7b
qry=silkie

syri -c out.filtered.coords -d out.filtered.delta -r $ref -q $qry --nc 38 --log DEBUG --all

python3 $PATH_TO_PLOTSR --sr syri.out -H 8 -W 5 -o 7b_vs_silkie_tochr30.svg -d 600 --genomes plotsr_genomes.txt \
--chr chr1 \
--chr chr2 \
--chr chr3 \
--chr chr4 \
--chr chr5 \
--chr chr6 \
--chr chr7 \
--chr chr8 \
--chr chr9 \
--chr chr10 \
--chr chr11 \
--chr chr12 \
--chr chr13 \
--chr chr14 \
--chr chr15 \
--chr chr16 \
--chr chr17 \
--chr chr18 \
--chr chr19 \
--chr chr20 \
--chr chr21 \
--chr chr22 \
--chr chr23 \
--chr chr24 \
--chr chr25 \
--chr chr26 \
--chr chr27 \
--chr chr28 \
--chr chr29 \
--chr chr30 \
--chr chr31 \
--chr chr33 \
--chr chr34 \
--chr chr36 \
--chr chr37 \
--chr chr38 \
--chr chrZ

