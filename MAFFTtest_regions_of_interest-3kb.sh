#!/bin/bash
#SBATCH --job-name=-3kbMAFFTtrial
#SBATCH --output=MAFFT_regions_of_interest_trial-3kb.log
#SBATCH --partition=macmanes
#SBATCH --exclude=node117,node118
#SBATCH --mem 115Gb

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis

module load linuxbrew/colsa

mafft --thread 8 --threadtb 5 --threadit 0 --reorder --auto regions_of_interestTEST-3kb.fa > MAFFT_regions_of_interest_trial_output-3kb.aln
