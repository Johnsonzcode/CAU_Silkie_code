####################repeat sequence masking###########################
######denove prediction
BuildDatabase -name silkie cau_silkie_chicken.fasta 
RepeatModeler -pa 30 -database silkie -LTRStruct

######Homologous prediction
####Find and export the repeat families of birds and their upper ancestor nodes, as well as all the groups below them
famdb.py -i RepeatMaskerLib.h5 families -f embl -a -d Aves > Aves_ad.embl
####Convert the assembly format to fasta format
buildRMLibFromEMBL.pl Aves_a.embl> Aves_a.fasta
####Merge ab initio and homologous prediction sequences
cat Aves_a.fasta silkie-families.fa >all.repeat.db.fasta
####repeat masking
RepeatMasker -xsmall -poly -pa 5 -lib all.repeat.db.fasta -engine ncbi cau_silkie.fna
