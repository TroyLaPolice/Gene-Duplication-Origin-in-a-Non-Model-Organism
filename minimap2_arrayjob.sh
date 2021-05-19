#!/bin/bash
#SBATCH -J imi_blat					# jobname
#SBATCH -o scripts/Minimap_SLURM_outputs/imi_miniRun.1o%A.%a	# jobname.o%j for single (non array) jobs jobname.o%A.%a for array jobs
#SBATCH -e scripts/Minimap_SLURM_outputs/imi_miniRun.1e%A.%a	# error file name A is the jobid and a is the arraytaskid
#SBATCH --cpus-per-task=4				# -c, --cpus-per-task=INT The # of cpus/task. env var for threads is SLURM_CPUS_PER_TASK
#SBATCH -p shared,macmanes				# queue (partition) -- normal, development, largemem, etc.
#SBATCH --mem=115G
#SBATCH --exclude=node117,node118
#SBATCH --array=0-9999%25

contigNum=$(( $SLURM_ARRAY_TASK_ID + 1 ))

module load linuxbrew/colsa

REF=/mnt/lustre/macmaneslab/tml1019/HapSolo/imitator.1.3.6.mmi

#JOBFILE contains a list of contig fasta files
JOBFILE=/mnt/lustre/macmaneslab/tml1019/HapSolo/jobfile.txt

SEED=$(head -n $contigNum $JOBFILE | tail -n 1)
QRY=${SEED}
minimap2 -x map-pb -t 36 -k19 -w5 -A1 -B2 -O3,13 -E2,1 -s200 -z200 -N50 --min-occ-floor=100 ${REF} ${QRY} > minimap_output/contig${contigNum}_$(basename ${QRY} .fasta)_self_align.paf
