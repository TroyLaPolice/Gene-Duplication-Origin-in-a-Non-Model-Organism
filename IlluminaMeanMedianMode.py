#! /usr/bin/env python3

import statistics

# empty list
depthList = []

try:
    with open("IlluminaDepth.tsv", "r") as input:

        for line in input:
            fields = line.split("\t")
            depthList.append(int(fields[2]))

except IOError:
    print("problem reading file")

print("Mean:  ", statistics.mean(depthList))
print("Median:  ", statistics.median(depthList))
print("Mode:  ", statistics.mode(depthList))
