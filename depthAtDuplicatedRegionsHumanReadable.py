#! /usr/bin/env python3

import csv

print("Scaffold Names:", "\t", "Coordinate:", "\t", "Depth:")
print("--------------------------------------------------")

illumina = open("IlluminaDepth.tsv")
read_illuminaDepth_tsv = csv.reader(illumina, delimiter="\t")

duplicates = open("duplicated_BUSCOoutput.tsv")
read_duplicates = csv.reader(duplicates, delimiter="\t")

try:
    for i in read_duplicates:
        try:
            for j in read_illuminaDepth_tsv:
                scaffold_names = (j[0])
                coordinates = int(j[1])
                endofDup = int(i[4])
                lower = int(i[3]) - 3000
                upper = int(i[4]) + 3000
                lowerplus2999 = (lower+2999)
                if i[2] == j[0] and coordinates >= (lower) and coordinates <= (upper):
                    if coordinates == lower:
                        print("**Start of Lower Bound:")
                        print(scaffold_names, "\t", coordinates, "\t", j[2])
                    elif coordinates == lowerplus2999:
                        print("**Duplicated Region Start:")
                        print(scaffold_names, "\t", coordinates, "\t", j[2])
                    elif coordinates == endofDup:
                        print(scaffold_names, "\t", coordinates, "\t", j[2])
                        print("**End of Duplicated Region")
                    elif coordinates == upper:
                        print(scaffold_names, "\t", coordinates, "\t", j[2])
                        print("**End of Lower Bound")
                        print("\n")
                    else:
                        print(scaffold_names, "\t", coordinates, "\t", j[2])
        except:
            print("Could not finish or depth loop")
except:
    print("Could not finish or enter the read_duplicates loop")

illumina.close()
duplicates.close()
