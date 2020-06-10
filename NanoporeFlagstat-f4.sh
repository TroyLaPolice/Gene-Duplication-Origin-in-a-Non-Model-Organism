#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J nanoF4fs
#SBATCH --output flagstatF4nano.log
#SBATCH --mem 115Gb
#SBATCH --exclude node117,node118

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Nanopore_aligned_reads

samtools flagstat -O tsv Nanopore_reads-F4.sam > flagstat_Nanopore_reads-F4.tsv
