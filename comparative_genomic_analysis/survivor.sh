SURVIVOR merge vcf_file.txt 1000 7 1 1 0 50 CAU_Silkie_vs_7_chicken.vcf
awk '$3~"DEL"{print $8}' CAU_Silkie_vs_7_chicken.vcf |awk -F '[:=;]' '{print $6}'|awk '{sum+=$1}END{print sum}'
