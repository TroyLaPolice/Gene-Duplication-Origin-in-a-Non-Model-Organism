# Methods for the initial exploratory phase

First step in the process is to run BUSCO on the genome and view the {full_table_Ranitomeya_imitator_genome_BUSCO.tsv} file to pull out gene duplications.

    See the script: Initial_BUSCO_run_pull_outDups.sh

Pull out only the duplicated genes from the full summary table and concatinate them into a single file
    
    grep "Duplicated" full_table_Ranitomeya_imitator_genome_BUSCO.tsv > duplicated_files.csv

Open CSV in Excel
Edit the column headers in the file as such:

    BUSCO ID    Status    Scaffold    Start    End    Score    Length




