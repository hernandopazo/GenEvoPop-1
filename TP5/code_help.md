neuron IPSC Trisomic
[SRR5874669](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418729)
[SRR5874670](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418728)
[SRR5874671](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418727)

neuron IPSC Disomic
[SRR5874672](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418726)
[SRR5874673](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418736)
[SRR5874674](https://www.ncbi.nlm.nih.gov/biosample/SAMN07418737)

Descomprimir archivos fasta y gff3 de la referencia
gzip -cdv Homo_sapiens.GRCh38.dna.chromosome.21.fa.gz > Homo_sapiens.GRCh38.dna.chromosome.21.fa
gzip -cdv Homo_sapiens.GRCh38.92.chromosome.21.gff3.gz > Homo_sapiens.GRCh38.92.chromosome.21.gff3


```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874669_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_T/r1/nIPSC_T_r1. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874670_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_T/r2/nIPSC_T_r2. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874671_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_T/r3/nIPSC_T_r3. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```

```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874672_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_D/r1/nIPSC_D_r1. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874673_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_D/r2/nIPSC_D_r2. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
```
STAR --runMode alignReads --runThreadN 3 --genomeDir /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874674_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_D/r3/nIPSC_D_r3. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
