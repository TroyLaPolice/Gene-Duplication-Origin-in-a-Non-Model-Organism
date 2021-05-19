#! /bin/bash
#SBATCH --partition=macmanes,shared
#SBATCH -J HapSolo
#SBATCH --output HapSolo.log
#SBATCH --mem=300000
#SBATCH --exclude=node117,node118
source ~/.profile

module purge
module load linuxbrew/colsa

export PATH=$HAPSOLO/scripts:$PATH

./hapsolo.py -i ../imitator.1.3.6_new.fa --paf ../imitator.paf -b ../contigs/busco
