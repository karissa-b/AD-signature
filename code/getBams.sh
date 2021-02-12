#!/bin/bash

#SBATCH -p batch                                                    
#SBATCH -N 1                                                    
#SBATCH -n 4                                                    
#SBATCH --time=24:00:00                                          
#SBATCH --mem=4GB 
#SBATCH -o /fast/users/a1211024/apoe_zhaoetal/%x_%j.out
#SBATCH -e /fast/users/a1211024/apoe_zhaoetal/%x_%j.err

#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=karissa.barthelson@adelaide.edu.au

#load the python virtual environment
module load Python/3.6.1-foss-2016b
source /fast/users/a1211024/virtualenvs/synapse/bin/activate

# change to where i want the bams
cd $FASTDIR/apoe_zhaoetal/bams

# download them
synapse get -r syn18457737 

# deactivate the virtualenv
deactivate

