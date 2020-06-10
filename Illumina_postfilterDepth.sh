#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J illFiltDepth
#SBATCH --output illFiltDepth.log
#SBATCH --mem 115Gb
source ~/.profile

module purge
module load linuxbrew/colsa

# samtools depth
samtools depth illumina_reads-F4.sam > illumina_reads-F4Depth.txt

# samtools depth
samtools depth illumina_reads-F256.sam > illumina_reads-F256Depth.txt

