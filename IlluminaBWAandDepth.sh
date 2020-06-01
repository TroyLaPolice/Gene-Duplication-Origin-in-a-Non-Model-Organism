#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J bwaill
#SBATCH --output illbwa.log
#SBATCH --cpus-per-task=40
#SBATCH --exclude node117,node118

DIR="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles"
ASSEMBLY="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles/imitator.1.3.6.fa"
READ1="/net/storage03/backup/archive/macmanes/reads/Stuckert/Ranitomeya_imitator/10x/trimmed10x.R1.fastq.gz"
READ2="/net/storage03/backup/archive/macmanes/reads/Stuckert/Ranitomeya_imitator/10x/trimmed10x.R2.fastq.gz"

module purge
module load linuxbrew/colsa

echo Running BWA on $ASSEMBLY

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/Illumina_aligned_reads

#bwa index ${DIR}/${ASSEMBLY}
bwa mem -t 40 $ASSEMBLY $READ1 $READ2 > illaln_TEMP.sam

samtools view illaln_TEMP.sam -@20 -Sb \
| samtools sort -T Illumina -O bam -@20 -l9 -m2G -o Illumina.sorted.bam -
samtools index Illumina.sorted.bam

# samtools depth
samtools depth Illumina.sorted.bam > IlluminaDepth.tsv
