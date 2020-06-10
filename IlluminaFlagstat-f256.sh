#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J IllF256fs
#SBATCH --output flagstatF256Ill.log
#SBATCH --mem 115Gb
#SBATCH --exclude node117,node118

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Illumina_aligned_reads

samtools flagstat -O tsv illumina_reads-F256.sam > flagstat_illumina_reads-F256.tsv
