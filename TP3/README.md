### [Trabajo Práctico N° 3. Control y pre-procesamiento de datos de NGS](https://docs.google.com/presentation/d/1JzTG1_mhRBua4LUjxI2eisYajbZ4622AnbSVs2ZcKZ8/edit?usp=sharing)<br/><br/>
**Ejercicio 1.** Exploración de archivos _fasta_ y _fastq_<br/><br/>
Una vez iniciada la máquina virtual, acceda a una terminal y sitúese en `/home/student/TP3`.<br/>
Los archivos que contienen las lecturas se encuentran en `/home/student/TP3/reads`<br/>
Utilizando comandos como `head` `tail` `less` explore los archivos _ejemplo.fasta_ y _ejemplo.fastq_ (tenga en cuenta que los archivos se encuentran comprimidos).<br/>
\- ¿Cuáles son las diferencias entre estos tipos de archivos?<br/><br/>
Explore los archivos con extensión _fastq_ de la carpeta.<br/>
Como lo sugieren en su nombre, estos archivos corresponden a secuencias producidas con tecnología Illumina, PacBio y Oxford Nanopore de distintos orígenes.<br/>
\- ¿Qué diferencias encuentra entre las lecturas producidas por las distintas tecnologías?

**Ejercicio 2.** Control de calidad de secuencias.

[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc) es un programa que permite visualizar estadísticas relacionadas a la calidad de la secuenciación en instrumentos de nueva generación, para determinar posibles desviaciones en los datos esperados.
Para ejecutar de forma interactiva, abrir un terminal y escribir `fastqc &` en la línea de comandos.
Desde el programa ir a _File -> Open_ y cargar el archivo _HISEQ4K\_wgs\_1.fastq.gz_. Los análisis se comenzarán a realizar automáticamente. Realizar los mismo para el archivo _HISEQ4K\_wgs\_2.fastq.gz_.<br/>
\- ¿Cuántas lecturas tiene cada archivo?<br/>
\- ¿Cuál es el largo de las lecturas?<br/>
\- ¿Cómo se comportan las lecturas hacia el final?<br/>
\- ¿Qué análisis dan buen y mal resultado?<br/>
\- ¿Qué acciones se podrían realizar para mejorar la calidad?

Explorar y discutir las distintas opciones que ofrece el programa, y repetir para el conjunto de archivos con extensión _.fastq_. Note que desde el programa se puede acceder a una ayuda sobre esto yendo a _Help -> Contents... -> Analysis Modules_.

\- ¿Qué puede decir sobre las distintas tecnologías y sets de datos?

**Ejercicio 3.** Procesamiento de lecturas.<br/><br/>
Dependiendo de lo observado en el análisis de calidad inicial, las secuencias pueden ser filtradas por calidad, longitud, y recortadas de distintas formas para mejorar su calidad global. También pueden eliminarse adaptarores incorporados durante el proceso de preparación de las librerías que hayan resultado secuenciados.<br/>
Para las lecturas provenientes de la plataforma Illumina, el programa [Trimmomatic](www.usadellab.org/cms/?page=trimmomatic) tiene la capacidad de realizar todas estas tareas, de forma rápida y flexible. En el [manual](https://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf) del programa se detallan sus distintas posibilidades y sintaxis.<br/><br/>
A continuación realizaremos las siguientes acciones en el set de datos paired-end _MISEQ\_wgs_:<br/>
. Eliminar los adaptadores que puedan estar presentes. Para esto se utilizará el archivo por defecto que contiene el programa con el parámetro `ILLUMINACLIP:/home/student/software/Trimmomatic-0.38/adapters/TruSeq3-PE.fa` (recordar que puede utilizarse cualquier archivo adicional con secuencias propias que crea que pueden estar contaminado los datos).<br/>
. Recortar los nucleótidos del comienzo y del final de las lecuras si tienen una calidad menor que cierto umbral. Se utilizará un valor umbral de calidad igual a 10 mediante los parámetros `LEADING:10` `TRAILING:10`.<br/>
. Restringir que la calidad de las lecturas no caiga por debajo de cierto umbral medio en una ventana de longitud determinada. Se utilizara un valor umbral de calidad igual a 10 en una venta de 6 nucleótidos, mediante el parámetro `SLIDINGWINDOW:6:10`.<br/>
. Descartar aquellas lecturas que luego del procesado tengan menos de 50 nucleótidos, utilizando el parámetro `MINLEN:50`.<br/>
Para ello, primero crear una carpeta llamada `trimm` dentro de la carpeta `/home/student/TP3/reads/`, y luego ejecutar la siguiente línea de código:
```
trimmomatic PE -trimlog /home/student/TP3/reads/trimm/MISEQ_wgs_trimming.log \
/home/student/TP3/reads/MISEQ_wgs_1.fastq.gz /home/student/TP3/reads/MISEQ_wgs_2.fastq.gz \
/home/student/TP3/reads/trimm/MISEQ_wgs_trim_1p.fastq.gz \
/home/student/TP3/reads/trimm/MISEQ_wgs_trim_1u.fastq.gz \
/home/student/TP3/reads/trimm/MISEQ_wgs_trim_2p.fastq.gz \
/home/student/TP3/reads/trimm/MISEQ_wgs_trim_2u.fastq.gz \
ILLUMINACLIP:/home/student/software/Trimmomatic-0.38/adapters/TruSeq3-PE.fa:2:30:10 \
LEADING:10 TRAILING:10 SLIDINGWINDOW:6:10 MINLEN:50
```

Explorar el registro generado (archivo _.log_). Visualizar en FastQC los archivos generados.<br/>
\- ¿Cuántas lecturas quedaron?<br/>
\- ¿Mejoró la calidad?

Volver a ejecutar Trimmomatic pero modificando los parámetros por `LEADING:20` `TRAILING:20` `SLIDINGWINDOW:4:20`. Comparar con el resultado obtenido anteriormente.<br/>
A partir de la información que se encuentra en el manual del programa:<br/>
\- ¿Podría usar los parámetros `HEADCROP` y `CROP`?<br/>
\- ¿Qué cambio en el código debería introducir si el set de datos no fuera pareado?

Intentar mejorar las otras lecturas de Illumina disponibles.
