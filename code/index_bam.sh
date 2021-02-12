#!/bin/bash

#SBATCH -p batch 
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=2:00:00
#SBATCH --mem=8GB
#SBATCH --array=1-143
#SBATCH -o /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.out
#SBATCH -e /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.err
 
#set up email notifications
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=karissa.barthelson@adelaide.edu.au

# ~~ load in modules ~~
module load SAMtools/1.10-foss-2016b

# ~~ change directory to where the bam files are

cd $FASTDIR/apoe_zhaoetal/03_alignedData_STAR/bams

BAM=`ls ${SLURM_ARRAY_TASK_ID}_*sortedByCoord.out.bam`
samtools index ${BAM} ${BAM}.bai

