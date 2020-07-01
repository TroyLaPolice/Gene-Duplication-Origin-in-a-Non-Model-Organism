#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J NanoMini
#SBATCH --output NanoMiniMap.log
#SBATCH --cpus-per-task=40
#SBATCH --mem=300000
#SBATCH --exclude=node117,node118

DIR="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles"
ASSEMBLY="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles/imitator.1.3.6.fa"
READS="/net/storage03/backup/archive/macmanes/reads/Stuckert/Ranitomeya_imitator/nanopore/basecalled_data/allcombinedNanoporedataJune2019.fastq"

module purge
module load linuxbrew/colsa

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Nanopore_aligned_reads

minimap2 -x map-ont -I50g -N 10 -a -t 40 $ASSEMBLY $READS | samtools view -Sb - | samtools sort -T Nanopore -O bam -@40 -l9 -m2G -o NanoporeMiniMap.sorted.bam -

samtools index NanoporeMiniMap.sorted.bam

# samtools depth
samtools depth -aa NanoporeMiniMap.sorted.bam > NanoporeMiniMapDepth.tsv
