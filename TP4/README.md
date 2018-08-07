### [Trabajo Práctico N° 4. Introducción al Ensamblado Genómico](https://docs.google.com/presentation/)<br/><br/>


**Ejercicio 1.** Ensamblado _de novo_ y evaluación.

En primer lugar se utilizará [ABySS](http://www.bcgsc.ca/platform/bioinfo/software/abyss/), un ensamblador que resulta adecuado para una primera ronda de ensamblajes ya que su ejecución es sencilla y no requiere grandes recursos computacionales. Además de ser flexible en cuanto a los tamaños genómicos que soporta, requiere que se declare un valor de kmer para la construcción del grafo.

Una vez iniciada la máquina virtual, acceda a una terminal y sitúese en `/home/student/TP4`.<br/>
En la carpeta `/home/student/TP4/reads/` hay lecturas provenientes de la secuenciación de ADN mitocondrial humano producidas con tecnología Illumina [single-read](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=DRR001063) y [paired-end](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR2075910), pero de experimentos distintos. También hay lecturas Illumina de una secuenciación simulada de _Staphylococcus aureus_.<br/>
\- ¿Hace falta realizar sobre las lecturas algún procesado relacionado con la calidad de secuenciación?<br/><br/>

Debido a que ABySS requiere que se declare un valor de Kmer, una estrategia que se suele utilizar es realizar distintos ensamblados modificando ese parámetro para luego seleccionar el mejor dentro de una métrica en particular.
Explore el script `abyss_script.sh`.<br/>
\- ¿Qué sucede si ejecutamos la siguiente líneas de código?: `seq 29 2 47`

Ejecutando el siguiente código puede ver el funcionamiento del script:

    for i in $(seq 29 2 47); do echo abyss -k "$i" /home/student/TP4/reads/sra_data.fastq \
    –o /home/student/TP4/abyss/contigs-k"$i".fa; done
\- ¿Cuántos ensamblados generará el script?

A continuación se utilizará la misma idea del script para crear todos lo directorios necesarios para los distintos ensamblados que se llevaran a cabo. Ejecute las siguientes líneas de código:

    for i in $(seq 29 2 47); do mkdir -p /home/student/TP4/assemblies/mitoSINGLE/abyss/k"$i"; done

    for i in $(seq 29 2 47); do mkdir -p /home/student/TP4/assemblies/mitoPAIRED/abyss/k"$i"; done

    for i in $(seq 29 2 47); do mkdir -p /home/student/TP4/assemblies/S.aureus/abyss/k"$i"; done


