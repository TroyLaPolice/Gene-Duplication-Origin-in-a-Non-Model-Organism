#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J bwaMini
#SBATCH --output PBMiniMap.log
#SBATCH --cpus-per-task=40
#SBATCH --mem=300000
#SBATCH --exclude=node117,node118

DIR="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles"
ASSEMBLY="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles/imitator.1.3.6.fa"
READS="/mnt/lustre/macmaneslab/ams1236/imitator_genome/reads/PacBio_reads.fa"

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/PacBio_aligned_reads

minimap2 -x map-pb -I50g -N 10 -a -t 40 $ASSEMBLY $READS | samtools view -Sb - | samtools sort -T PacBio -O bam -@40 -l9 -m2G -o PacBioMiniMap.sorted.bam -

samtools index PacBioMiniMap.sorted.bam

# samtools depth
samtools depth -aa PacBioMiniMap.sorted.bam > PacBioMiniMapDepth.tsv
