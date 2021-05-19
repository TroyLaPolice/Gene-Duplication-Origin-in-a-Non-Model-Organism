#! /bin/bash
#SBATCH --partition=macmanes,shared
#SBATCH -J minimapIndex
#SBATCH --output minimapIndex.log
#SBATCH --mem=300G
#SBATCH --exclude=node117,node118
source ~/.profile

module load linuxbrew/colsa

minimap2 -x map-pb -I50g -d ../imitator.1.3.6.mmi /mnt/lustre/macmaneslab/shared/Stuckert/Stuckert_Ranitomeya_imitator_genome/imitator.1.3.6.fa
