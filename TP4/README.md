### [Trabajo Práctico N° 4. Introducción al Ensamblado Genómico](https://docs.google.com/presentation/)<br/><br/>


**Ejercicio 1.** Ensamblado _de novo_ con ABySS

En primer lugar se utilizará [ABySS](http://www.bcgsc.ca/platform/bioinfo/software/abyss/), un ensamblador que resulta adecuado para una primera ronda de ensamblajes ya que su ejecución es sencilla y no requiere grandes recursos computacionales. Además de ser flexible en cuanto a los tamaños genómicos que soporta, requiere que se declare un valor de kmer para la construcción del grafo.

Una vez iniciada la máquina virtual, acceda a una terminal y sitúese en `/home/student/TP4`.<br/>
En la carpeta `/home/student/TP4/reads/` hay lecturas provenientes de la secuenciación de ADN mitocondrial humano producidas con tecnología Illumina [single-read](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=DRR001063) y [paired-end](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR2075910), pero de experimentos distintos. También hay lecturas Illumina de una secuenciación simulada de _Staphylococcus aureus_.<br/>
\- ¿Hace falta realizar algún procesado sobre las lecturas relacionado con la calidad de secuenciación? ¿En qué set de lecturas? Si fuera el caso, procesar el set que haga falta con Trimmomatic de la misma forma que lo hecho anteriormente en el [TP3](https://github.com/lunfardista/GenEvoPop/tree/master/TP3), pero además combinar los dos archivos desapareados resultantes (si los hubiera) en uno solo.<br/><br/>

Debido a que ABySS requiere que se declare un valor de Kmer, una estrategia que se suele utilizar es realizar distintos ensamblados modificando ese parámetro para luego seleccionar el mejor dentro de una métrica en particular. Para tal fin, se construyó el script `abyss_scripts.sh`. Explore el archivo e intente identificar las distintas secciones del código.<br/>
\- ¿Qué sucede si ejecutamos la siguiente líneas de código?: `seq 29 2 47`

Ejecutando el siguiente código puede tener una idea más clara del funcionamiento del script:

    for i in $(seq 29 2 47); do echo abyss -C /home/student/TP4/assemblies/mitoPAIRED/abyss/k"$i" k="$i" \
    name=Saur.k"$i" in='/home/student/TP4/reads/sim_Staur_1.fq.gz /home/student/TP4/reads/sim_Staur_2.fq.gz'; \
    done
\- ¿Cuántos ensamblados generará el script para cada set de datos?

A continuación se utilizará la misma idea del script para crear todos lo directorios necesarios para los distintos ensamblados que se llevaran a cabo con ABySS. Ejecute las siguientes líneas de código:<br/>

`for i in $(seq 29 2 47); do mkdir -p /home/student/TP4/assemblies/mitoPAIRED/abyss/k"$i"; done`

`for i in $(seq 29 2 47); do mkdir -p /home/student/TP4/assemblies/mitoSINGLE/abyss/k"$i"; done`

`for i in $(seq 29 2 47); do mkdir -p /home/student/TP4/assemblies/S.aureus/abyss/k"$i"; done`

Para correr el script, ejecute en la terminal la siguiente línea de código:<br/>
`./abyss_scripts.sh/`

El segmento de código ejecutado corresponde a la secuenciación single-read. Para ejecutar las otras secciones del código, hay que comentar la sección ya ejecutada y descomentar las que se quiera ejecutar. Esto se hace añadiento y eliminando el caracter `#` de las líneas necesarias. Ejecute el script para cada sección de código.

ABySS facilita una rápida y básica inspección de los resultados obtenidos a partir de una tabla que se guarda en un archivo finalizado en "stats" dentro del directorio de cada ensamblado. Para visualizar comparativamente los ensamblados realizados con distintos valores de kmer, ejecute la siguiente linea de código en la terminal:<br/>
`cat /home/student/TP4/assemblies/mitoSINGLE/abyss/k*/*stats`

El asterisco (`*`) significa que ahí puede haber 0 o más caracteres. En google puede encontrar más información sobre [wildcards](http://tldp.org/LDP/GNU-Linux-Tools-Summary/html/x11655.htm) y [regular expressions](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_01.html) muy útiles en la terminal.<br/>

\- ¿Cómo guardaría esos resultados en un archivo llamado `abyss_mitoSINGLE.rslts`? Realice lo mismo para los otros grupos de ensamblados.

\- ¿Cuáles fueron los mejores ensamblados en cada caso?

\- Si se tiene en cuenta que el genoma mitocondrial humano tiene un tamaño de 16569bp, ¿cuál es el mejor ensamblado para la mitocondria humana? ¿Por qué?


**Ejercicio 2.** Ensamblado _de novo_ con SPAdes

A continuación vamos a repetir los ensamblados pero con otro programa: [SPAdes](http://cab.spbu.ru/software/spades/). Este ensamblador funciona muy bien con genomas chicos y no necesita que se declare un valor de kmer ya que usa una estrategia multi-kmer predetermianda.

Ejecute las siguientes líneas de código para crear todos lo directorios necesarios para los distintos ensamblados que se llevaran a cabo con SPAdes:<br/>

`for i in $(seq 29 2 47); do mkdir -p /home/student/TP4/assemblies/mitoPAIRED/abyss/k"$i"; done`

`for i in $(seq 29 2 47); do mkdir -p /home/student/TP4/assemblies/mitoSINGLE/abyss/k"$i"; done`

`for i in $(seq 29 2 47); do mkdir -p /home/student/TP4/assemblies/S.aureus/abyss/k"$i"; done`

Ejecute el siguiente código en la terminal para ensamblar las lecturas resultantes del set de datos paired-end de mitocondria: 

    python /home/student/software/SPAdes-3.12.0-Linux/bin/spades.py \
    -1 /home/student/TP4/reads/MISEQ_SRR2075910_trim_1p.fastq.gz \
    -2 /home/student/TP4/reads/MISEQ_SRR2075910_trim_2p.fastq.gz \
    -s /home/student/TP4/reads/MISEQ_SRR2075910_trim_u.fastq.gz --only-assembler \
    --careful -t 2 -m 4 -o /home/student/TP4/assemblies/mitoPAIRED/spades

\- ¿Cómo cambiaría el código para correr los set de datos restantes?


**Ejercicio 3.** Evaluación del ensamblado

Para evaluar ensamblados de una forma completa e informativa, se utilizará el programa [QUAST](http://cab.spbu.ru/software/quast).



