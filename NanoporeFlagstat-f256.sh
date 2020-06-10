#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J NanoF256filter
#SBATCH --output F256filterNano.log
#SBATCH --mem 115Gb
#SBATCH --exclude node117,node118

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Nanopore_aligned_reads

samtools view -h -F 256 Nanopore.sorted.bam > Nanopore_reads-F256.sam
