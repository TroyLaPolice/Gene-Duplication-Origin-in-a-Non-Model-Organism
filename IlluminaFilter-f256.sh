#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J IllF256filter
#SBATCH --output filterF256Ill.log
#SBATCH --cpus-per-task=40
#SBATCH --exclude node117,node118

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Illumina_aligned_reads

samtools view -h -F 256 Illumina.sorted.bam > illumina_reads-F256.sam
