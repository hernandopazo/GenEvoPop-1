**E.1**
Identidad de las lecturas:
- neuron IPSC Trisomic<br/>
[SRR5874669](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418729)<br/>
[SRR5874670](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418728)<br/>
[SRR5874671](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418727)

- neuron IPSC Disomic<br/>
[SRR5874672](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418726)<br/>
[SRR5874673](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418736)<br/>
[SRR5874674](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418737)
<br/>

Descomprimir archivos fasta y gff3 de la referencia:
```
gzip -cdv Homo_sapiens.GRCh38.dna.chromosome.21.fa.gz > Homo_sapiens.GRCh38.dna.chromosome.21.fa
gzip -cdv Homo_sapiens.GRCh38.92.chromosome.21.gff3.gz > Homo_sapiens.GRCh38.92.chromosome.21.gff3
```
<br/>

Alineamiento de los transcriptomas a la referencia:
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874669_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_T/r1/nIPSC_T_r1. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874670_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_T/r2/nIPSC_T_r2. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874671_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_T/r3/nIPSC_T_r3. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
<br/>
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874672_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_D/r1/nIPSC_D_r1. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874673_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_D/r2/nIPSC_D_r2. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874674_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_D/r3/nIPSC_D_r3. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
<br/><br/>

**E.2**
```
mkdir -p StringTie/nIPSC_D/r1 StringTie/nIPSC_D/r2 StringTie/nIPSC_D/r3 StringTie/nIPSC_T/r1 StringTie/nIPSC_T/r2 StringTie/nIPSC_T/r3
```


```
stringtie /home/estudiante/TP5/STAR/nIPSC_T/r1/nIPSC_T_r1.Aligned.sortedByCoord.out.bam -o /home/estudiante/TP5/StringTie/nIPSC_T/r1/nIPSC_T_r1.gtf -p 3 -G /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.92.chromosome.21.gff3 -l STRG.nIPSC_T_r1 -A /home/estudiante/TP5/StringTie/nIPSC_T/r1/nIPSC_T_r1.abund.tab -C /home/estudiante/TP5/StringTie/nIPSC_T/r1/nIPSC_T_r1.cov_refs.gtf -B -e -v
```
```
stringtie /home/estudiante/TP5/STAR/nIPSC_T/r2/nIPSC_T_r2.Aligned.sortedByCoord.out.bam -o /home/estudiante/TP5/StringTie/nIPSC_T/r2/nIPSC_T_r2.gtf -p 3 -G /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.92.chromosome.21.gff3 -l STRG.nIPSC_T_r2 -A /home/estudiante/TP5/StringTie/nIPSC_T/r2/nIPSC_T_r2.abund.tab -C /home/estudiante/TP5/StringTie/nIPSC_T/r2/nIPSC_T_r2.cov_refs.gtf -B -e -v
```
```
stringtie /home/estudiante/TP5/STAR/nIPSC_T/r3/nIPSC_T_r3.Aligned.sortedByCoord.out.bam -o /home/estudiante/TP5/StringTie/nIPSC_T/r3/nIPSC_T_r3.gtf -p 3 -G /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.92.chromosome.21.gff3 -l STRG.nIPSC_T_r3 -A /home/estudiante/TP5/StringTie/nIPSC_T/r3/nIPSC_T_r3.abund.tab -C /home/estudiante/TP5/StringTie/nIPSC_T/r3/nIPSC_T_r3.cov_refs.gtf -B -e -v
```

```
stringtie /home/estudiante/TP5/STAR/nIPSC_D/r1/nIPSC_D_r1.Aligned.sortedByCoord.out.bam -o /home/estudiante/TP5/StringTie/nIPSC_D/r1/nIPSC_D_r1.gtf -p 3 -G /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.92.chromosome.21.gff3 -l STRG.nIPSC_D_r1 -A /home/estudiante/TP5/StringTie/nIPSC_D/r1/nIPSC_D_r1.abund.tab -C /home/estudiante/TP5/StringTie/nIPSC_D/r1/nIPSC_D_r1.cov_refs.gtf -B -e -v
```
```
stringtie /home/estudiante/TP5/STAR/nIPSC_D/r2/nIPSC_D_r2.Aligned.sortedByCoord.out.bam -o /home/estudiante/TP5/StringTie/nIPSC_D/r2/nIPSC_D_r2.gtf -p 3 -G /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.92.chromosome.21.gff3 -l STRG.nIPSC_D_r2 -A /home/estudiante/TP5/StringTie/nIPSC_D/r2/nIPSC_D_r2.abund.tab -C /home/estudiante/TP5/StringTie/nIPSC_D/r2/nIPSC_D_r2.cov_refs.gtf -B -e -v
```
```
stringtie /home/estudiante/TP5/STAR/nIPSC_D/r3/nIPSC_D_r3.Aligned.sortedByCoord.out.bam -o/home/estudiante/TP5/StringTie/nIPSC_D/r3/nIPSC_D_r3.gtf -p 3 -G /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.92.chromosome.21.gff3 -l STRG.nIPSC_D_r3 -A /home/estudiante/TP5/StringTie/nIPSC_D/r3/nIPSC_D_r3.abund.tab -C /home/estudiante/TP5/StringTie/nIPSC_D/r3/nIPSC_D_r3.cov_refs.gtf -B -e -v
```



