# Methods

### Initial Exploratory Phase

##### Acquire the genome
Use the Ranitomeya imitator genome found at: 
       
    /mnt/lustre/macmaneslab/shared/Stuckert/Stuckert_Ranitomeya_imitator_genome

##### Find Duplicates

Run BUSCO on the genome and view the _full_table_Ranitomeya_imitator_genome_BUSCO.tsv_ file to pull out gene duplications.

    See the script: Initial_BUSCO_run_pull_outDups.sh (Below)
   [Initial_BUSCO_run_pull_outDups.sh](https://github.com/TroyLaPolice/Gene-Duplication-Origin-in-a-Non-Model-Organism/blob/master/Initial_BUSCO_run_pull_outDups.sh) 

Pull out only the duplicated genes from the full summary table and concatinate them into a single file
    
    grep "Duplicated" full_table_Ranitomeya_imitator_genome_BUSCO.tsv > duplicated_files.csv

##### Preliminary Analysis

Open CSV in Excel

Add the column headers in the file as such: 

    # These mirror the BUSCO column headers

    BUSCO ID    Status    Scaffold    Start    End    Score    Length

Delete string characters around each of the numbers in the saffold column.

    Find and replace ->  "scaffold" replace with nothing
    Find and replace ->  "_pilon_pilon" replace with nothing
    
    #This leaves behind only the numbers which I can work with in R
    
Use R to determine statistics about the dataset

    See the script: initial_R_dataAnalysisAndFigures.R (Below)
    
[initial_R_dataAnalysisAndFigures.R](https://github.com/TroyLaPolice/Gene-Duplication-Origin-in-a-Non-Model-Organism/blob/master/initial_R_dataAnalysisAndFigures.R)

##### Try to do a test alignment with two genes found very far away from each other

Used the BUSCO ID and Scaffold from the _full_table_Ranitomeya_imitator_genome_BUSCO.tsv_

Sampled a gene that was duplicated twice on scaffolds that were far apart in terms of the order they were assembled

       # In this case it was on scaffolds 9 and 6848
       # I need to unwrap the genome inorder to grep the sequence from it
       
       awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' imitator.1.3.6.fa > unwrapped_imitator.1.3.6.fa
       
     
________________________________________________________________________________________________________________________________________
**_This was used to align an entire scaffold which is largely impractical. Don't need to do this, can just pull out the region of interest_**

       # I pulled out each of the scafold chunks and put them into their own files
       
       grep "scaffold9_pilon_pilon" -A1 unwrapped_imitator.1.3.6.fa > scaffold9_pilon_pilon.fa
       grep "scaffold6848_pilon_pilon" -A1 unwrapped_imitator.1.3.6.fa> scaffold6848_pilon_pilon.fa
       
       # I cat them together
       
       cat scaffold6848_pilon_pilon.fa scaffold9_pilon_pilon.fa > MAFFTtrial.fa
       
Take this file and test run a MAFFT alignment

    See the script: MAFFTtrial.sh (Below)
    
[MAFFTtrial.sh](https://github.com/TroyLaPolice/Gene-Duplication-Origin-in-a-Non-Model-Organism/blob/master/MAFFTtrial.sh)

________________________________________________________________________________________________________________________________________
**_I did it again but this time with only the portion of the scaffold that was of interest_**

Need to load linuxbrew/colsa so I can use bedtools [getfasta](https://bedtools.readthedocs.io/en/latest/content/tools/getfasta.html) function

       bedtools getfasta will extract the sequence defined by the coordinates in a BED interval 
       and create a new FASTA entry in the output file for each extracted sequence. By default, 
       the FASTA header for each extracted sequence will be formatted as follows: 
       “<chrom>:<start>-<end>”.
       
Command:

       bedtools getfasta -fi unwrapped_imitator.1.3.6.fa -fo regions_of_interestTEST.fa -bed id_file.tsv
       
       -fo	Specify an output file name. By default, output goes to stdout.
       -fi    Input fasta file, i used the unwrapped genome
       -bed   ID file that is required with gene coordinates
       #For -bed I pulled out the given beginning and ending coordinates of the gene of interest

See the ID file (bed): id_file.tsv (Below)
    
[id_file.tsv](https://github.com/TroyLaPolice/Gene-Duplication-Origin-in-a-Non-Model-Organism/blob/master/id_file.tsv)

Take the bedtools output fasta file and test run a MAFFT alignment

    See the script: MAFFTtest_regions_of_interest.sh (Below)
    
[MAFFTtest_regions_of_interest.sh](https://github.com/TroyLaPolice/Gene-Duplication-Origin-in-a-Non-Model-Organism/blob/master/MAFFTtest_regions_of_interest.sh)
