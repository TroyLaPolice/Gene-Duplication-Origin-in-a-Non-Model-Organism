#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J nanoF4filter
#SBATCH --output filter4nano.log
#SBATCH --mem 115Gb
#SBATCH --exclude node117,node118

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Nanopore_aligned_reads

samtools view -h -F 4 Nanopore.sorted.bam > Nanopore_reads-F4.sam
