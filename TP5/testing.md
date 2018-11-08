### [Trabajo Práctico N° 5. RNA-Seq: Introducción al análisis de expresión diferencial](https://docs.google.com/presentation/d/1gRdamhUnbwNt5dH0sQ93gvowMjzmFqAlxWwkxLSCHgI/edit?usp=sharing) <br/><br/>


**Ejercicio 1.** Alineamiento de lecturas de RNA-Seq a una referencia genómica

Para mapear lecturas provenientes de secuenciación transcriptómica a un genoma de referencia, se utilizará [STAR](https://github.com/alexdobin/STAR), un alineador para datos de RNA-Seq moderno, rápido y ligero.<br/>

- ¿Qué diferencias tiene que tener un programa que mapea lecturas de RNA-Seq con uno que mapea lecturas de WGS?

Se utilizará un set de datos reducido de [Gonzales _et al._ (2018)](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0194581) en el cual se evalúa la expresión diferencial entre células con trisomía para el cromosoma 21 y células control, con tres réplicas biológicas en cada caso.<br/>
Explore los datos del [proyecto](https://www.ncbi.nlm.nih.gov/bioproject/395984). Verifique los nombres de los archivos en la carpeta `/home/estudiante/TP5/reads` (SRR5874669 al SRR5874674) a través del [browser del Sequence Read Archive](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=run_browser) y acceda a los datos de cada muestra.

- ¿Cuáles son las réplicas trisómicas y cuáles son las disómicas? ¿De qué tipo de células se trata?


En primer lugar hay que indexar la referencia sobre la que se va a mapear, en este caso la referencia es un subset que consiste solo en el cromosoma 21 (notar que hay que descomprimir los archivos archivos _fasta_ y _gff3_).<br/>
Crear el directorio `/home/estudiante/TP5/ref_genome/index` y ejecutar la siguiente línea de código:
```
STAR --runThreadN 3 --runMode genomeGenerate --genomeDir /home/estudiante/TP5/ref_genome/index --genomeFastaFiles /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.dna.chromosome.21.fa --sjdbGTFfile /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.92.chromosome.21.gff3 --sjdbGTFtagExonParentTranscript Parent
```
<br/>

A continuación se realizarán los mapeos de cada transcriptoma a la referencia.<br/>
Dentro de `/TP5`, crear los directorios necesarios utilizando la siguiente línea de código:
```
mkdir -p STAR/nIPSC_D/r1 STAR/nIPSC_D/r2 STAR/nIPSC_D/r3 STAR/nIPSC_T/r1 STAR/nIPSC_T/r2 STAR/nIPSC_T/r3`
```

Para mapear el transcriptoma correspondiente a la primer réplica biológica de las células nIPSC Trisómicas, ejecute la siguiente línea de código:
```
STAR --runMode alignReads --runThreadN 3 --genomeDir  /home/estudiante/TP5/ref_genome/index --readFilesIn /home/estudiante/TP5/reads/SRR5874669_c21_sub.fastq.gz --readFilesCommand zcat --outFileNamePrefix /home/estudiante/TP5/STAR/nIPSC_T/r1/nIPSC_T_r1. --outSAMattrIHstart 0 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate
```

- Modifique de forma correspondiente la línea de código anterior para ejecutar los 5 alineamientos restantes. Explore el contenido del archivo con terminación _.Log.final.out_ que se genera en cada caso. ¿Cómo resultaron los mapeos?

- Teniendo en cuenta lo realizado en el TP4, ¿cómo haría para visulizar los alineamientos con IGV?
<br/><br/><br/>


**Ejercicio 2.** Cálculo de la expresión génica

Para hacer un conteo de lecturas y calcular datos de expresión génica, se va a utilizar el programa [StringTie](https://ccb.jhu.edu/software/stringtie/), un ensamblador de transcriptos basado en referencia que a su vez calcula valores de expresión.

Dentro de `/TP5`, crear los directorios necesarios utilizando la siguiente línea de código:
```
mkdir -p StringTie/nIPSC_D/r1 StringTie/nIPSC_D/r2 StringTie/nIPSC_D/r3 StringTie/nIPSC_T/r1 StringTie/nIPSC_T/r2 StringTie/nIPSC_T/r3
```

Para ejecutar StringTie sobre los datos correspondientes a la primer réplica biológica de las células nIPSC Trisómicas, utilice la siguiente línea de código:
```
stringtie /home/estudiante/TP5/STAR/nIPSC_T/r1/nIPSC_T_r1.Aligned.sortedByCoord.out.bam -o /home/estudiante/TP5/StringTie/nIPSC_T/r1/nIPSC_T_r1.gtf -p 3 -G /home/estudiante/TP5/ref_genome/Homo_sapiens.GRCh38.92.chromosome.21.gff3 -l STRG.nIPSC_T_r1 -A /home/estudiante/TP5/StringTie/nIPSC_T/r1/nIPSC_T_r1.abund.tab -C /home/estudiante/TP5/StringTie/nIPSC_T/r1/nIPSC_T_r1.cov_refs.gtf -B -e -v
```
Modifique de forma correspondiente la línea de código anterior para los cinco set de datos restantes. Explore los archivos generados. Observe los parámetros utilizados en la ejecución de StringTie, ¿qué función cumplen los parámetros _-B_ y _-e_?


A continuación se realizará una tabla con los conteos de los seis sets de datos utilizando un script desarrollado por los autores de StringTie.
Para ejecutarse, el script requiere que generemos un archivo de texto en el cual le indiquemos el nombre de cada tratamiento y la ruta del archivo .gtf generado por StringTie.
Crear un archivo llamado _sample_lst.txt_ dentro de la carpeta `/StringTie` que contenga lo siguiente:
```
nIPSC_T_r1	/home/estudiante/TP5/StringTie/nIPSC_T/r1/nIPSC_T_r1.gtf
nIPSC_T_r2	/home/estudiante/TP5/StringTie/nIPSC_T/r2/nIPSC_T_r2.gtf
nIPSC_T_r3	/home/estudiante/TP5/StringTie/nIPSC_T/r3/nIPSC_T_r3.gtf
nIPSC_D_r1	/home/estudiante/TP5/StringTie/nIPSC_D/r1/nIPSC_D_r1.gtf
nIPSC_D_r2	/home/estudiante/TP5/StringTie/nIPSC_D/r2/nIPSC_D_r2.gtf
nIPSC_D_r3	/home/estudiante/TP5/StringTie/nIPSC_D/r3/nIPSC_D_r3.gtf
```

Para crear la tabla de conteos, ejecutar la siguiente línea de código:
```
python2.7 /home/estudiante/TP5/prepDE.py -i /home/estudiante/TP5/StringTie/sample_lst.txt -g /home/estudiante/TP5/StringTie/gene_count_matrix.csv -t /home/estudiante/TP5/StringTie/transcript_count_matrix.csv -l 126
```

Explore la tabla de genes obtenida. Utilice el comando `sed -i 's/gene://' gene_count_matrix.csv` para modificar el nombre de los genes de forma apropiada.
<br/><br/>


**Ejercicio 3.** Análisis de expresión diferencial

Para analizar la expresión diferencial entre las condiciones se van a utilizar paquetes (programas) específicos para el lenguaje de programación estadística [R](https://cran.r-project.org/), usando [RStudio](https://www.rstudio.com/) como interfaz.
Todas las instrucciones para este ejercicio se encuentran en el archivo _expresion.R_ en la carpeta `/TP5`.
Crear la carpeta `/home/estudiante/TP5/DE` y abrir el archivo _expresion.R_ con RStudio

Una vez obtenida la lista de genes diferencialmente expresados explorar las webs de [g:Profiler](https://biit.cs.ut.ee/gprofiler/index.cgi), [HumanMine](http://www.humanmine.org/humanmine/bag.do?subtab=upload), [Reactome](https://reactome.org/PathwayBrowser/#TOOL=AT) y [STRING](https://string-db.org/cgi/input.pl?input_page_active_form=multiple_identifiers). Discutir los resultados.

