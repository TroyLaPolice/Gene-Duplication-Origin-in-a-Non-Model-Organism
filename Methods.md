# Methods

### Initial Exploratory Phase

##### Acquire the genome
Use the Ranitomeya imitator genome found at: 
       
    /mnt/lustre/macmaneslab/shared/Stuckert/Stuckert_Ranitomeya_imitator_genome

##### Find Duplicates

Run BUSCO on the genome and view the {full_table_Ranitomeya_imitator_genome_BUSCO.tsv} file to pull out gene duplications.

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

###### Acquire the genome
