#!/bin/bash

#SBATCH -p batch 
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=4:00:00
#SBATCH --mem=4GB
#SBATCH --array=1-143
#SBATCH -o /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.out
#SBATCH -e /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.err
 
# ~~ set up email notifications ~~

#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=karissa.barthelson@adelaide.edu.au
   
# ~~ Load in modules ~~ 
module load Java/1.8.0_121
module load AdapterRemoval/2.2.1-foss-2016b

# ~~ change to raw data directory ~~

cd $FASTDIR/apoe_zhaoetal/01_rawdata

# ~~ set some variables ~~

FIRSTREAD=`ls ${SLURM_ARRAY_TASK_ID}_*1.fastq.gz`
SECONDREAD=`ls ${SLURM_ARRAY_TASK_ID}_*2.fastq.gz`

# ~~ Run adapterRemoval ~~  
AdapterRemoval \
      --gzip \
      --trimns \
      --trimqualities \
      --minquality 30 \
      --minlength 35 \
      --threads 8 \
      --output1 /fast/users/a1211024/apoe_zhaoetal/02_trimmedData/${FIRSTREAD%,fastq.gz}_T1.fastq.gz \
      --output2 /fast/users/a1211024/apoe_zhaoetal/02_trimmedData/${SECONDREAD%.fastq.gz}_T2.fastq.gz \
      --file1 ${FIRSTREAD} \
      --file2 ${SECONDREAD}
