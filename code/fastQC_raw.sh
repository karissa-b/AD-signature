#!/bin/bash

#SBATCH -p batch 
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=4:00:00
#SBATCH --mem=4GB
#SBATCH --array=42,108,109
#SBATCH -o /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.out
#SBATCH -e /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.err
 
#set up email notifications
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=karissa.barthelson@adelaide.edu.au

# Load in modules
module load Java/1.8.0_121
module load fastqc/0.11.4

# change to the fastq directory
cd $FASTDIR/apoe_zhaoetal/01_rawdata

# set some variables

OUTDIR="/fast/users/a1211024/apoe_zhaoetal/01_rawdata/fastqc"
FIRSTREAD=`ls ${SLURM_ARRAY_TASK_ID}_*1.fastq.gz`
SECONDREAD=`ls ${SLURM_ARRAY_TASK_ID}_*2.fastq.gz`

# do fastQC

fastqc -t 8 -f fastq -o ${OUTDIR} ${FIRSTREAD}
fastqc -t 8 -f fastq -o ${OUTDIR} ${SECONDREAD}
