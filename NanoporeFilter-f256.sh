#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J NanoF256filter
#SBATCH --output F256filterNano.log
#SBATCH --mem 115Gb
#SBATCH --exclude node117,node118

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Nanopore_aligned_reads

#the F filters and the -h keeps the header in the file, this is important for later
samtools view -h -F 256 Nanopore.sorted.bam > Nanopore_reads-F256.sam
