Filtrar lecturas:
```
trimmomatic PE /home/estudiante/TP4/reads/MISEQ_SRR2075910_1.fastq.gz /home/estudiante/TP4/reads/MISEQ_SRR2075910_2.fastq.gz /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_1p.fastq.gz /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_1u.fastq.gz /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_2p.fastq.gz /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_2u.fastq.gz ILLUMINACLIP:/home/estudiante/software/Trimmomatic-0.38/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:5:20 MINLEN:50
```

Combinar lecturas desapareadas en un mismo archivo:
```
zcat /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_1u.fastq.gz > /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_u.fastq; zcat /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_2u.fastq.gz >> /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_u.fastq; gzip /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_u.fastq
```

Alineamiento de las lecturas paired-end:
```
hisat2 -p 2 -x /home/estudiante/TP4/alignments/index/Homo_sapiens.GRCh37.74.dna.chromosome.MT -1 /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_1p.fastq.gz -2 /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_2p.fastq.gz -S /home/estudiante/TP4/alignments/mitoPAIRED/MISEQ_SRR2075910_trim.sam
```
