tgsgapcloser \
        --scaff  jelly.out.fasta \
        --reads  Chicken_ONT_corrected.fasta \
        --output test_ne  \
        --ne \
        --samtools ~/yin/software/anaconda3/envs/asm_practise/bin/samtools \
        --java  ~/yin/software/anaconda3/envs/asm_practise/bin/java \
        --thread 130 \
        >pipe.log 2>pipe.err
