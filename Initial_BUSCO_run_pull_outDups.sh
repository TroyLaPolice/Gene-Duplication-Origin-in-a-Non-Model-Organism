#!/bin/bash
#SBATCH --job-name=genome_metrics
#SBATCH --output=genome.metrics.log
#SBATCH --cpus-per-task=40
#SBATCH --partition=macmanes
#SBATCH --exclude=node117,node118
# echo commands to stdout
set -x

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis

###### BUSCO analysis
## Tetrapoda lineage
cp /mnt/lustre/macmaneslab/shared/Stuckert/Stuckert_Ranitomeya_imitator_genome/tetrapoda.config.ini .
mv tetrapoda.config.ini config.ini

export AUGUSTUS_CONFIG_PATH="/mnt/lustre/macmaneslab/tml1019/seniorThesis/config"

#run BUSCO on Ranitomeya_imitator_genome found in /mnt/lustre/macmaneslab/shared/Stuckert/Stuckert_Ranitomeya_imitator_genome/imitator.1.3.6.fa
busco -i /mnt/lustre/macmaneslab/shared/Stuckert/Stuckert_Ranitomeya_imitator_genome/imitator.1.3.6.fa -m geno --cpu 40 -o Ranitomeya_imitator_genome_BUSCO


