### [Trabajo Práctico N° 4. Introducción al Ensamblado Genómico](https://docs.google.com/presentation/)<br/><br/>


**Ejercicio 1.** Ensamblado _de novo_ y evaluación.

En primer lugar se utilizará [ABySS](http://www.bcgsc.ca/platform/bioinfo/software/abyss/), un ensamblador que resulta adecuado para una primera ronda de ensamblajes ya que su ejecución es sencilla y no requiere grandes recursos computacionales. Además de ser flexible en cuanto a los tamaños genómicos que soporta, requiere que se declare un valor de kmer para la construcción del grafo.

Una vez iniciada la máquina virtual, acceda a una terminal y sitúese en `/home/student/TP4`.<br/>
En la carpeta `/home/student/TP4/reads/` hay lecturas provenientes de la secuenciación de ADN mitocondrial humano producidas con tecnología Illumina [single-read](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=DRR001063) y [paired-end](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR2075910), pero de experimentos distintos. También hay lecturas Illumina de una secuenciación simulada de _Staphylococcus aureus_.<br/>
\- ¿Hace falta realizar sobre las lecturas algún procesado relacionado con la calidad de secuenciación?<br/><br/>
