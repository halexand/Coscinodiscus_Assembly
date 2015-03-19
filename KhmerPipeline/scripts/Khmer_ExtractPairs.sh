#!/bin/bash

#PBS -k o 
#PBS -q batch
#PBS -l nodes=1:ppn=2,vmem=10gb,walltime=10:00:00 
#PBS -M alexandh@indiana.edu 
#PBS -m abe 
#PBS -N Trim_DeepDOM
#PBS -j oe


#load java 

module load java
module load python/2.7.3
module load khmer/1.0


wd=/N/dc2/projects/ldeo/Cosci_Culture/Coscinodiscus_Assembly/KhmerPipeline/data
cd $wd


tail1=.pe.qc.fq.gz

#Interleave the sequences using Khmer utility: interleave-reads. Note: this is being run on data that has already been quality trimmed with Trimmomatic and had the extensions removed. 

for i in SH*${tail1}
do
    /N/soft/rhel6/khmer/1.0_2_g2c43bdb/scripts/extract-paired-reads.py $i

done

exit 0

(END)

