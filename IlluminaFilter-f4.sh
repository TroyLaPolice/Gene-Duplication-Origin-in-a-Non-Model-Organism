#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J IllF4filter
#SBATCH --output filterF4Ill.log
#SBATCH --cpus-per-task=40
#SBATCH --exclude node117,node118

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Illumina_aligned_reads

#the F filters and the -h keeps the header in the file, this is important for later

samtools view -h -F 4 Illumina.sorted.bam > illumina_reads-F4.sam
