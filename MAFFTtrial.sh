#!/bin/bash
#SBATCH --job-name=MAFFtrial
#SBATCH --output=MAFFTtrial.log
#SBATCH --partition=macmanes
#SBATCH --exclude=node117,node118
#SBATCH --mem 115Gb

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis

module load linuxbrew/colsa

mafft --thread 8 --threadtb 5 --threadit 0 --reorder --auto MAFFTtrial.fa > MAFFTtrial_output
