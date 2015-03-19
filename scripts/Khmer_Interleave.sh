#!/bin/bash

#PBS -k o 
#PBS -q batch
#PBS -l nodes=1:ppn=8,vmem=100gb,walltime=40:00:00 
#PBS -M alexandh@indiana.edu 
#PBS -m abe 
#PBS -N Trim_Cosci
#PBS -j oe


#load java 
module load java
module load python/2.7.3
module load khmer/1.0
wd=/N/dc2/projects/ldeo/Cosci_Culture/Coscinodiscus_Assembly/KhmerPipeline/data/trim
cd $wd


tail1=R1_001.fastq

#Interleave the sequences using Khmer utility: interleave-reads. Note: this is being run on data that has already been quality trimmed with Trimmomatic and had the extensions removed. 

for myFile in ../SH*${tail1}
do
    stripped=${myFile%$tail1}
    filename=${stripped//_*}
    filename=${filename##*/}
    echo "working on stripped $stripped ->  ../$filename"
    tail3=${tail1/R1/R2}
    java -jar /N/dc2/projects/MMETSP/Trimmomatic-0.27/trimmomatic-0.27.jar PE -phred33 $stripped$tail1 $stripped$tail3 s1_pe s1_se s2_pe s2_se SLIDINGWINDOW:6:20 MINLEN:25
    /N/soft/rhel6/khmer/1.0_2_g2c43bdb/scripts/interleave-reads.py s1_pe s2_pe | gzip -9c > ../${filename}.pe.qc.fq.gz
    cat s1_se s2_se | gzip -9c > ../${filename}.se.qc.fq.gz
done

cd ..
chmod u-w *.pe.qc.fq.gz *.se.qc.fq.gz

for i in *.pe.qc.fq.gz
do
    /N/soft/rhel6/khmer/1.3/bin/extract-paired-reads.py $i
done

exit 0

(END)
