#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J IllF4fs
#SBATCH --output flagstatF4Ill.log
#SBATCH --cpus-per-task=40
#SBATCH --exclude node117,node118

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Illumina_aligned_reads

samtools flagstat -O tsv illumina_reads-F4.sam > flagstat_illumina_reads-F4.tsv
