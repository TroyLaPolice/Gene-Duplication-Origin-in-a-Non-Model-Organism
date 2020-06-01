#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J bwaPB
#SBATCH --output PBbwa.log
#SBATCH --cpus-per-task=40
#SBATCH --exclude node117,node118

DIR="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles"
ASSEMBLY="/mnt/lustre/macmaneslab/tml1019/seniorThesis/genomeFiles/imitator.1.3.6.fa"
READS="/mnt/lustre/macmaneslab/ams1236/imitator_genome/reads/PacBio_reads.fa"

module purge
module load linuxbrew/colsa

echo Running BWA on $ASSEMBLY

cd /mnt/lustre/macmaneslab/tml1019/seniorThesis/BWAandDepth/PacBio_aligned_reads

#bwa index ${DIR}/${ASSEMBLY}
bwa mem -t 40 -x pacbio $ASSEMBLY $READS > PBaln_TEMP.sam

samtools view PBaln_TEMP.sam -@20 -Sb \
| samtools sort -T PacBio -O bam -@20 -l9 -m2G -o PacBio.sorted.bam -
samtools index PacBio.sorted.bam

# samtools depth
samtools depth PacBio.sorted.bam > PacBioDepth.tsv
