### [Trabajo Práctico N° 4. Introducción al ensamblado/mapeo genómico](https://docs.google.com/presentation/d/1gRdamhUnbwNt5dH0sQ93gvowMjzmFqAlxWwkxLSCHgI/edit?usp=sharing)<br/><br/>


**Ejercicio 1.** Ensamblado _de novo_ con ABySS

En primer lugar se utilizará [ABySS](http://www.bcgsc.ca/platform/bioinfo/software/abyss/), un ensamblador que resulta adecuado para una primera ronda de ensamblajes ya que su ejecución es sencilla y no requiere grandes recursos computacionales. A su vez, otras características que posee este programa se encuentra su flexibilidad en cuanto a los tamaños genómicos que soporta, y que requiere que se declare un valor de k-mer para la construcción del grafo.

Una vez iniciada la máquina virtual, acceda a una terminal y sitúese en `/home/estudiante/TP4`<br/>
En la carpeta `/home/estudiante/TP4/reads` hay lecturas provenientes de secuenciaciones de ADN mitocondrial humano producidas con tecnología Illumina [single-read](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=DRR001063) y [paired-end](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR2075910), pero de experimentos distintos. También hay lecturas Illumina de una secuenciación simulada de _Staphylococcus aureus_.<br/>
\- ¿Hace falta realizar algún procesado sobre las lecturas relacionado con la calidad de secuenciación? ¿En qué set de lecturas? Si fuera el caso, procesar el set que haga falta con Trimmomatic de la misma forma que lo hecho anteriormente en el [TP3](https://github.com/lunfardista/GenEvoPop/tree/master/TP3), pero además combinar los dos archivos desapareados resultantes (si los hubiera) en uno solo (¿cómo haría eso?).<br/>

Debido a que ABySS requiere que se declare un valor de k-mer, una estrategia que se suele utilizar es realizar distintos ensamblados modificando ese parámetro para luego seleccionar el mejor dentro de una métrica en particular. Para tal fin, se construyó el script `abyss_scripts.sh`. Explore el archivo e intente identificar las distintas secciones del código.<br/>
\- ¿Qué sucede si ejecutamos la siguiente líneas de código?:
```
seq 29 2 47
```

Ejecutando el siguiente código puede tener una idea más clara sobre el funcionamiento del script:
```
for i in $(seq 29 2 47); do echo abyss-pe -C /home/estudiante/TP4/assemblies/S.aureus/abyss/k"$i" k="$i" name=Saur.k"$i" in='/home/estudiante/TP4/reads/sim_Staur_1.fq.gz /home/estudiante/TP4/reads/sim_Staur_2.fq.gz'; done
```
\- ¿Cuántos ensamblados generará el script para cada set de datos?

A continuación se utilizará la misma idea del script para crear todos lo directorios necesarios para los distintos ensamblados que se llevaran a cabo con ABySS. Ejecute las siguientes líneas de código:
```
for i in $(seq 29 2 47); do mkdir -p /home/estudiante/TP4/assemblies/mitoPAIRED/abyss/k"$i"; done
```
```
for i in $(seq 29 2 47); do mkdir -p /home/estudiante/TP4/assemblies/mitoSINGLE/abyss/k"$i"; done
```
```
for i in $(seq 29 2 47); do mkdir -p /home/estudiante/TP4/assemblies/S.aureus/abyss/k"$i"; done
```

Para correr el script, ejecute en la terminal (estando ubicado en el directorio `TP4`) la siguiente línea de código:
```
./abyss_scripts.sh
```

El segmento de código ejecutado corresponde a la secuenciación single-read. Para ejecutar las otras secciones del código, hay que comentar la sección ya ejecutada y descomentar las que se quiera ejecutar. Esto se hace añadiento y eliminando el caracter `#` de las líneas necesarias, ¿se le ocurre una forma de hacerlo con el comando `sed`? Ejecute el script para cada sección de código.

ABySS facilita una rápida y básica inspección de los resultados obtenidos a partir de una tabla que se guarda en un archivo finalizado en "stats" dentro del directorio de cada ensamblado. Para visualizar comparativamente los ensamblados realizados con distintos valores de kmer, ejecute la siguiente linea de código en la terminal:
```
cat /home/estudiante/TP4/assemblies/mitoSINGLE/abyss/k*/*stats
```

El asterisco (`*`) significa que ahí puede haber 0 o más caracteres. En _Google_ puede encontrar más información sobre [wildcards](http://tldp.org/LDP/GNU-Linux-Tools-Summary/html/x11655.htm) y [regular expressions](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_01.html), muy útiles en la terminal.<br/>

\- ¿Cómo guardaría esos resultados en un archivo llamado `abyss_mitoSINGLE.rslts`? Realice lo mismo para los otros grupos de ensamblados.

\- ¿Cuáles fueron los mejores ensamblados en cada caso?

\- Si se tiene en cuenta que el genoma mitocondrial humano tiene un tamaño de 16569bp, ¿cuál es el mejor ensamblado para la mitocondria humana? ¿Por qué?<br/><br/>


**Ejercicio 2.** Ensamblado _de novo_ con SPAdes

A continuación vamos a repetir los ensamblados pero con otro programa: [SPAdes](http://cab.spbu.ru/software/spades/). Este ensamblador funciona muy bien con genomas chicos y no necesita que se declare un valor de kmer ya que usa una estrategia multi-kmer predetermianda.

En primer lugar hay que crear un directorio llamado `spades` dentro de cada uno de los tres subdirectorios que se encuentran en `/assemblies`

Ejecute el siguiente código en la terminal para ensamblar las lecturas resultantes del set de datos paired-end de mitocondria: 
```
python spades -1 /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_1p.fastq.gz -2 /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_2p.fastq.gz -s /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_u.fastq.gz --only-assembler --careful -t 2 -m 4 -o /home/estudiante/TP4/assemblies/mitoPAIRED/spades
```

\- ¿Cómo cambiaría el código para correr los set de datos restantes?
<br/><br/>

**Ejercicio 3.** Evaluación del ensamblado

Para evaluar ensamblados de una forma completa e informativa, se utilizará el programa [QUAST](http://cab.spbu.ru/software/quast).

En primer lugar se evaluarán los distintos ensamblados realizados con los sets de datos de mitocondria humana. Debido a que existe un genoma mitocondrial humano de referencia, la información de su secuencia y anotación se puede utilizar para obtener mejores estadísticas.

En primer lugar crear una carpeta llamada `quast` dentro de `/assemblies`, con una subcarpeta llamada `mitoSINGLE`. A continuación elegir los que creemos son los dos mejores ensamblados priducidos con ABySS para el set de datos single-read y el ensamblado porducido con SPAdes, y ejecutar un código similar al siguiente:
```
python quast.py -o /home/estudiante/TP4/assemblies/quast/mitoSINGLE -R /home/estudiante/TP4/ref_genome/Homo_sapiens.GRCh37.74.dna.chromosome.MT.fa.gz -g /home/estudiante/TP4/ref_genome/HS.MT.gff.gz -t 2 -l abss39.SE,abss41.SE,spds.SE --circos --single /home/estudiante/TP4/reads/GA2_DRR001063_redset.fastq.gz /home/estudiante/TP4/assemblies/mitoSINGLE/abyss/k39/Hsap_mitoSE.k39-unitigs.fa /home/estudiante/TP4/assemblies/mitoSINGLE/abyss/k41/Hsap_mitoSE.k41-unitigs.fa /home/estudiante/TP4/assemblies/mitoSINGLE/spades/scaffolds.fasta
```

Abrir el archivo report.html que se genera en la carpeta de salida con un navegador y explorar todos los recursos que ofrece.

\- ¿Que evaluación podría hacer de los ensamblados? ¿Cuál es el mejor?

Repita el procedimiento para los otros sets de datos, creando las carpetas necesarias y modificando el código para ejecutar QUAST como sea necesario.<br/><br/>


**Ejercicio 4.** Alineamiento a una referencia y visualización

Para mapear las lecturas al genoma de referencia se utilizará [HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml), un alineador ampliamente utilizado que tiene la ventaja de ser ultra rápido y a su vez eficiente en relación a la cantidad de memoria que utiliza.

Crear un directorio llamado `alignments` con un subdirectorio llamado `index_hs2` dentro del directorio `/TP4`<br/>
Ejecute la siguiente línea de código para descomprimir el genoma de referencia y ubicarlo en otro directorio:
```
gunzip -c /home/estudiante/TP4/ref_genome/Homo_sapiens.GRCh37.74.dna.chromosome.MT.fa.gz > /home/estudiante/TP4/alignments/index_hs2/Homo_sapiens.GRCh37.74.dna.chromosome.MT.fa
```
A continuación, hay que crear un índice del genóma de referencia mediante la siguiente línea de código:
```
hisat2-build /home/estudiante/TP4/alignments/index_hs2/Homo_sapiens.GRCh37.74.dna.chromosome.MT.fa /home/estudiante/TP4/alignments/index_hs2/Homo_sapiens.GRCh37.74.dna.chromosome.MT
```
Luego, crear un directorio llamado `mitoSINGLE` y otro llamado `mitoPAIRED` dentro del directorio `/alignments`<br/>
Finalmente, se alinean las lecturas al genoma de referencia mediante la siguiente línea de código:
```
hisat2 -p 2 -x /home/estudiante/TP4/alignments/index/Homo_sapiens.GRCh37.74.dna.chromosome.MT -U /home/estudiante/TP4/reads/GA2_DRR001063_redset.fastq.gz -S /home/estudiante/TP4/alignments/mitoSINGLE/GA2_DRR001063_redset.sam
```

\- ¿Cuántas lecturas alinearon a la referencia?<br/><br/>

Para visualizar el mapeo de las lecturas contra el genoma de referencia vamos a utilizar el programa [IGV](http://software.broadinstitute.org/software/igv), pero antes es necesario convertir el alineamiento de formato _SAM_ (Sequence Alignment/Map) a formato _BAM_ (Binary Alignment/Map). Para eso utilizaremos el programa [SAMtools](http://www.htslib.org), que proporciona un set de herramientas para procesar esa clase de archivos.

Primero se convierte el alineamiento en formato SAM a formato BAM con la siguiente línea de código:
```
samtools view -b /home/estudiante/TP4/alignments/mitoSINGLE/GA2_DRR001063_redset.sam > /home/estudiante/TP4/alignments/mitoSINGLE/GA2_DRR001063_redset.bam
```

Luego, el archivo BAM debe ser ordenado e indexado mediante las siguientes líneas de código:
```
samtools sort -o /home/estudiante/TP4/alignments/mitoSINGLE/GA2_DRR001063_redset.sorted.bam /home/estudiante/TP4/alignments/mitoSINGLE/GA2_DRR001063_redset.bam
```
```
samtools index /home/estudiante/TP4/alignments/mitoSINGLE/GA2_DRR001063_redset.sorted.bam
```

A continuación, abra IGV ejecutando en la línea de comandos de la termial `igv &`<br/>
Para importar el genoma de referencia y junto con la información y localizaciones de sus genes, se realizaran las siguientes acciones:<br/>
. En el menú _**Genomes**_ seleccione _**Create .genome File...**_<br/>
. Completar los campos de la siguiente forma:<br/>
.. en el campo _Unique identifier_ puede ingresar "HsapMT" o algún otro identificador corto<br/>
.. en el campo _Descriptive name_ puede ingresar "H. sapiens mitochondria 37.74" o alguna otra descripción<br/>
.. en el campo _FASTA file_ tiene que ingresar el archivo fasta que se encuentra en el directorio `/home/estudiante/TP4/alignment/index`<br/>
.. en el campo _Gene File_ tien que ingresar el archivo de anotación GTF que se encuentra en el directorio `/home/estudiante/TP4/ref_genome`<br/>
. Luego se carga el archivo genreado anteriormente `GA2_DRR001063_redset.sorted.bam` desde el menú _File_ seleccionando _Load from file..._<br/>

\- ¿Qué observa?<br/>

Coloree los reads de acuerdo al strand oprimiendo Click derecho sobre un read y seleccionando _**Color alignments by**_ y luego _**read strand**_.<br/>
Consulte la guía de usuario desde el menú _**Help**_ seleccionando _**User Guide...**_



