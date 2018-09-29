#!/bin/bash

## Script para ejecutar los ejemplos del TP4 con ABySS assembler
## v.062018 
## dndepanis@ege.fcen.uba.ar




## Segmento del script para single-reads (ejemplo mitocondria H. sapiens sinlge-reads)

for i in $(seq 29 2 47)
        do
                echo -._.-._.-._.-._.-._.-._.-._.-._.-._.-._.- k = "$i" -._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-
                echo
               /home/estudiante/software/abyss-2.1.0/bin/abyss-pe -C /home/estudiante/TP4/assemblies/mitoSINGLE/abyss/k"$i" k="$i" name=Hsap_mitoSE.k"$i" se=/home/estudiante/TP4/reads/GA2_DRR001063_redset.fastq.gz
                echo
                echo
done




## Segmento del script para paired-end reads y unpaired (ejemplo mitocondria H. sapiens paired-end reads procesadas)

#for i in $(seq 29 2 47)
#        do
#                echo -._.-._.-._.-._.-._.-._.-._.-._.-._.-._.- k = "$i" -._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-
#                echo
#               /home/estudiante/software/abyss-2.1.0/bin/abyss-pe -C /home/estudiante/TP4/assemblies/mitoPAIRED/abyss/k"$i" k="$i" name=Hsap_mitoPE.k"$i" in=\'/home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_1p.fastq.gz /home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_2p.fastq.gz\' se=\'/home/estudiante/TP4/reads/MISEQ_SRR2075910_trim_u.fastq.gz'
#                echo
#                echo
#done




## Segmento del script para paired-end reads (ejemplo S. aureus)

#for i in $(seq 29 2 47)
#	do
#		echo -._.-._.-._.-._.-._.-._.-._.-._.-._.-._.- k = "$i" -._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-
#		echo
#		/home/estudiante/software/abyss-2.1.0/bin/abyss-pe -C /home/estudiante/TP4/assemblies/mitoPAIRED/abyss/k"$i" k="$i" name=Saur.k"$i" in=\'/home/estudiante/TP4/reads/sim_Staur_1.fq.gz /home/estudiante/TP4/reads/sim_Staur_2.fq.gz\'
#		echo
#		echo
#done
