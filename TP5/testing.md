### [Trabajo Práctico N° 5. RNA-Seq: Introducción al análisis de expresión diferencial](https://docs.google.com/presentation/d/1gRdamhUnbwNt5dH0sQ93gvowMjzmFqAlxWwkxLSCHgI/edit?usp=sharing)<br/><br/>


**Ejercicio 1.** Alineamiento de lecturas de RNA-Seq a una referencia genómica

Para mapear lecturas provenientes de secuenciación transcriptómica a un genoma de referencia, se utilizará [STAR](https://github.com/alexdobin/STAR), un alineador para datos de RNA-Seq moderno, rápido y ligero.

¿Qué diferencias tiene que tener un programa que mapea lecturas de RNA-Seq con uno que mapea lecturas de WGS?

Se utilizará un set de datos reducido de [Gonzales _et al._ (2018)](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0194581) en el cual se evalúa la expresión diferencial entre células con trisomía para el cromosoma 21 y células control.
Explore los datos del [proyecto](https://www.ncbi.nlm.nih.gov/bioproject/395984). Verifique los nombres de los archivos en la carpeta `/home/estudiante/TP5/reads` (SRR5874669 al SRR5874674) a través del [browser del Sequence Read Archive](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=run_browser) y acceda a los datos de cada muestra. ¿Cuáles son las réplicas trisómicas y cuáles son las disómicas? ¿De qué tipo de células se trata?

En primer lugar hay que indexar la referencia sobre la que se va a mapear, en este caso la referencia es un subset que consiste solo en el cromosoma 21 (notar que hay que descomprimir los archivos archivos fasta y gff3).
Crear directorio el directorio `/home/estudiante/TP5/ref_genome/index` y ejecutar la siguiente línea de código:
```
STAR --runThreadN 3 --runMode genomeGenerate --genomeDir /home/estudiante/TP5/ref_genome/index --genomeFastaFiles /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.dna.chromosome.21.fa --sjdbGTFfile /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.92.chromosome.21.gff3 --sjdbGTFtagExonParentTranscript Parent
```

A continuación se realizarán los mapeos de cada transcriptoma a la referencia.
Dentro de `/TP5`, crear los directorios necesarios utilizando la siguiente línea de código:
`mkdir -p STAR/nIPSC_D/r1 STAR/nIPSC_D/r2 STAR/nIPSC_D/r3 STAR/nIPSC_T/r1 STAR/nIPSC_T/r2 STAR/nIPSC_T/r3`

Para mapear el transcriptoma correspondiente a la primer réplica biológica de las células nIPSC Trisómicas, ejecute la siguiente línea de código:
```
STAR --runMode alignReads --runThreadN 3 --genomeDir  /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874669_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_T/r1/nIPSC_T_r1. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```
