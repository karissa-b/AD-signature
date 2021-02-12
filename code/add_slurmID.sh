#!/bin/bash
#this script adds in a SLURM array ID number in front of each read name 
# i.e. mut_R1.fastq.gz > 1_mut_R1.fastq.gz
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

cd $FASTDIR/apoe_zhaoetal/01_rawdata

        ID=1
        for firstread in *R1.fastq.gz
        do
                mv $firstread ${ID}_${firstread}
                ID=$(expr $ID + 1)
        done

        ID=1
        for secondread in *R2.fastq.gz
        do
                mv $secondread ${ID}_${secondread}
                ID=$(expr $ID + 1)
        done

ID=1
for index in *I2.fastq.gz
do
mv $index ${ID}_${index}
ID=$(expr $ID + 1)
done


