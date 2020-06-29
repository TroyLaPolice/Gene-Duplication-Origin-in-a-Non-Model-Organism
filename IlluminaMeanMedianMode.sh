#! /bin/bash
#SBATCH --partition=macmanes,shared
#SBATCH -J IllStats
#SBATCH --output illStatsMeanMedianMode.log
#SBATCH --mem 115Gb
source ~/.profile

module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Illumina_aligned_reads

./IlluminaMeanMedianMode.py
