#!/bin/bash

#PBS -k o 
#PBS -q batch
#PBS -l nodes=1:ppn=8,vmem=20gb,walltime=40:00:00 
#PBS -M alexandh@indiana.edu 
#PBS -m abe :
#PBS -N Trim_DeepDOM
#PBS -j oe


#load java 

module load java
module load python/2.7.3
module load khmer/1.3

wd=/N/dc2/projects/ldeo/Cosci_Culture/Coscinodiscus_Assembly/KhmerPipeline/work
/N/soft/rhel6/khmer/1.3/bin/normalize-by-median.py -p -k 20 -C 20 -N 4 -x 3e9 --savetable normC20k20.kh *.pe.qc.fq.gz

/N/soft/rhel6/khmer/1.3/bin/normalize-by-median.py -C 20 --loadtable normC20k20.kh --savetable normC20k20.kh *.se.qc.fq.gz



