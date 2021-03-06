#!/bin/bash
#SBATCH --partition=macmanes
#SBATCH -J illStats
#SBATCH --output illStats.log
#SBATCH --cpus-per-task=40
source ~/.profile

echo "***************************************"
echo "STARTING DEPTH GREATER OR LESS THAN... "
echo "***************************************"

awk -v x=10 '$3 < x' IlluminaDepth.tsv > illumina_reads-Depthlessthan10.tsv
awk -v x=10 '$3 > x' IlluminaDepth.tsv > illumina_reads-Depthgreaterthan10.tsv
awk -v x=20 '$3 > x' IlluminaDepth.tsv > illumina_reads-Depthgreaterthan20.tsv
awk -v x=30 '$3 > x' IlluminaDepth.tsv > illumina_reads-Depthgreaterthan30.tsv

echo "***************************************"
echo "DEPTH GREATER OR LESS THAN IS NOW DONE!"
echo "***************************************"

echo "***************************************"
echo "STARTING wc -l... "
echo "***************************************"

echo "STARTING wc -l illumina_reads-Depthlessthan10.tsv"
wc -l illumina_reads-Depthlessthan10.tsv

echo "STARTING wc -l illumina_reads-Depthgreaterthan10.tsv"
wc -l illumina_reads-Depthgreaterthan10.tsv

echo "STARTING wc -l illumina_reads-Depthgreaterthan20.tsv"
wc -l illumina_reads-Depthgreaterthan20.tsv

echo "STARTING wc -l illumina_reads-Depthgreaterthan30.tsv"
wc -l illumina_reads-Depthgreaterthan30.tsv

echo "***************************************"
echo "wc -l IS NOW DONE!"
echo "***************************************"

echo "***************************************"
echo "STARTING MEAN MEDIAN MODE... "
echo "***************************************"

awk '{sum+=$3;a[x++]=$3;b[$3]++}b[$3]>Mode{Mode=$3}END{print "Mean: " sum/x "\nMedian: "a[int((x-1)/2)]"\nMode: " Mode}' IlluminaDepth.tsv > meanmedianmode_output_illumina_readsDepth.tsv

echo "***************************************"
echo "MEAN MEDIAN MODE IS NOW DONE!"
echo "***************************************"
