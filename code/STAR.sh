#!/bin/bash

#SBATCH -p batch 
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=5:00:00
#SBATCH --mem=32GB
#SBATCH --array=137
#SBATCH -o /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.out
#SBATCH -e /fast/users/a1211024/apoe_zhaoetal/logs/%x_%j.err
 
#set up email notifications
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=karissa.barthelson@adelaide.edu.au

# ~~ load in modules ~~

module load STAR/2.7.0d-foss-2016b
module load SAMtools/1.10-foss-2016b

# ~~ change directory to where the trimmed files are

cd $FASTDIR/apoe_zhaoetal/02_trimmedData

# ~~ Specify variables ~~

FIRSTREAD=`ls ${SLURM_ARRAY_TASK_ID}_*T1.fastq.gz`
SECONDREAD=`ls ${SLURM_ARRAY_TASK_ID}_*T2.fastq.gz`

OUTDIR="/fast/users/a1211024/apoe_zhaoetal/03_alignedData_STAR/bams"
GENOMEDIR="/data/biorefs/reference_genomes/ensembl-release-98/mus_musculus/star"

# ~~ Run STAR ~~

STAR \
        --runThreadN 8 \
	--limitBAMsortRAM 39299657946 \
        --genomeDir ${GENOMEDIR} \
        --readFilesIn ${FIRSTREAD} ${SECONDREAD} \
        --readFilesCommand gunzip -c \
        --outFileNamePrefix ${OUTDIR}/${SECONDREAD%%.bam_R2_T2.fastq.gz} \
        --outSAMtype BAM SortedByCoordinate

# ~~ mv logs to own directory ~~

cd $FASTDIR/apoe_zhaoetal/03_alignedData_STAR/bams

mv *tab logs
mv *out logs


