#!/bin/bash
#SBATCH -J imi_busco3					# jobname
#SBATCH -o BUSCOoutputs/imi_busco3Run.o%A.%a	# jobname.o%j for single (non array) jobs jobname.o%A.%a for array jobs
#SBATCH -e BUSCOoutputs/imi_busco3Run.e%A.%a	# error file name A is the jobid and a is the arraytaskid
#SBATCH --cpus-per-task=4				# -c, --cpus-per-task=INT The # of cpus/task. env var for threads is SLURM_CPUS_PER_TASK
#SBATCH -p shared,macmanes				# queue (partition) -- normal, development, largemem, etc.
#SBATCH --mem=115G
#SBATCH --exclude=node117,node118
#SBATCH --array=0-9999%25

contigNum=$(( $SLURM_ARRAY_TASK_ID + 1 ))
module load linuxbrew/colsa

#please load your BUSCO, Augustus, BRAKER binaries here
export AUGUSTUS_CONFIG_PATH=/mnt/lustre/macmaneslab/tml1019/HapSolo/scripts/config

#please copy to contigs directory and run in that directory
#please run bash_buscopreprocess.sh prior to running this

INPUTTYPE="geno"
#please enter the directory for your ODB9 libraries here
MYLIBDIR="/mnt/lustre/macmaneslab/ams1236/busco_downloads/lineages"

#tetrapoda
MYLIB="tetrapoda_odb10"
SPTAG="human"

cd /mnt/lustre/macmaneslab/tml1019/HapSolo/contigs

OPTIONS="-l ${MYLIBDIR}/${MYLIB} -sp ${SPTAG}"
JOBFILE="buscojobfile.txt"

mkdir -p busco
[ -d busco/busco${arrayID} ] && rm -rf busco/busco${contigNum}
mkdir -p busco/busco${contigNum}
TMPDIR="./busco/busco${contigNum}"
CWDIR=$(pwd)

SEED=$(head -n ${contigNum} ${JOBFILE} | tail -n 1)
cd ${TMPDIR}

ln -s /mnt/lustre/macmaneslab/tml1019/HapSolo/scripts/config.ini

echo "Begin analysis on ${SEED}"
#removes escape chars and spaces. bug fix for mummer. mummer will not take escape characters and spaces in fasta headers
#echo "Begin removing invalid characters in header on ${SEED}"
ln -sf ../../${SEED}
#cat ${SEED} | sed -r 's/[/ =,\t|]+/_/g' | awk -F "_" '{ if (/^>/) {printf($1"_"$2"\n")} else {print $0} }' > $(basename ${SEED} .fasta)_new.fasta
#QRY=$(basename ${SEED} .fasta)_new.fasta
QRY=${SEED}

echo "Begin quast analysis on ${QRY}"
quastrun="quast.py -t ${SLURM_CPUS_PER_TASK} ${QRY} -o quast_$(basename ${QRY} .fasta)"
echo $quastrun
$quastrun
echo "End quast analysis, cat results and begin busco run"
cat quast_$(basename ${QRY} .fasta)/report.txt > ${CWDIR}/$(basename ${QRY} .fasta)_scoresreport.txt

buscorun="busco -c ${SLURM_CPUS_PER_TASK} -i ${QRY} -m ${INPUTTYPE} -o $(basename ${QRY} .fasta)_${MYLIB}_${SPTAG} ${OPTIONS} -t ./run_$(basename ${QRY} .fasta)_${MYLIB}_${SPTAG}/tmp"
echo $buscorun
$buscorun
echo "End busco run and cat results"
cat run_$(basename ${QRY} .fasta)_${MYLIB}_${SPTAG}/short*.txt >> ${CWDIR}/$(basename ${QRY} .fasta)_scoresreport.txt
cd ..
#tar czf busco${contigNum}.tar.gz busco${contigNum}
#rm -rf busco${contigNum}
echo "Finished on ${QRY}"

