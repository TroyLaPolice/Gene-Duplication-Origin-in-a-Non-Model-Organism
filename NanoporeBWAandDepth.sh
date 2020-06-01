#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J bwaNano
#SBATCH --output bwa.log
#SBATCH --cpus-per-task=40
#SBATCH --exclude node117,node118

DIR="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles"
ASSEMBLY="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles/imitator.1.3.6.fa"
READS="/net/storage03/backup/archive/macmanes/reads/frog/nanopore/basecalled_data/allcombinedNanoporedataJune2019.fastq"

module purge
module load linuxbrew/colsa

echo Running BWA on $ASSEMBLY

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth

mkdir Nanopore_aligned_reads
cd Nanopore_aligned_reads

#bwa index ${DIR}/${ASSEMBLY}
bwa mem -t 40 -x ont2d $ASSEMBLY $READS > aln_TEMP.sam

samtools view aln_TEMP.sam -@20 -Sb \
| samtools sort -T Nanopore -O bam -@20 -l9 -m2G -o Nanopore.sorted.bam -
samtools index Nanopore.sorted.bam

# samtools depth
samtools depth Nanopore.sorted.bam > nanoDepth.txt
