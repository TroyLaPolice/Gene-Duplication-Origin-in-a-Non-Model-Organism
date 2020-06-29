#! /bin/bash
#SBATCH --partition=macmanes,shared
#SBATCH -J depthDup
#SBATCH --output depthAtDuplicatedRegionsHumanReadable.log
source ~/.profile

module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Illumina_aligned_reads

./depthAtDuplicatedRegionsHumanReadable.py
