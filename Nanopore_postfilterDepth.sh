#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J NanoFiltDepth
#SBATCH --output NanoFiltDepth.log
#SBATCH --mem 115Gb
source ~/.profile

module purge
module load linuxbrew/colsa

# samtools depth
samtools depth Nanopore_reads-F4.sam > Nanopore_reads-F4Depth.txt

# samtools depth
samtools depth Nanopore_reads-F256.sam > Nanopore_reads-F256Depth.txt

