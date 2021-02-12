#!/bin/bash

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 12
#SBATCH --time=14:00:00
#SBATCH --mem=8GB
#SBATCH -o /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.out
#SBATCH -e /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.err

#set up email notifications
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=karissa.barthelson@adelaide.edu.au

#load in modules
module load Subread/1.5.2-foss-2016b
module load Java/1.8.0_121


# move to bam dir
cd $FASTDIR/apoe_zhaoetal/03_alignedData_STAR/bams 

featureCounts -a $FASTDIR/apoe_zhaoetal/Mus_musculus.GRCm38.98.chr.gtf \
	-Q 10 \
        -T 12 \
        -o $FASTDIR/apoe_zhaoetal/04_featurecounts/featureCounts_q10_ensRelease98.txt \
	-p \
        *.bam




