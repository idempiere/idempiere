#!/bin/bash

# Explore the repository to the lowest level and count file types

# Use find command to list all files and directories
find . -type f | awk -F. '{
    if (NF>1) {
        ext[$NF]++
    } else {
        ext["no_extension"]++
    }
} END {
    for (e in ext) {
        print e, ext[e]
    }
}' > file_summary.txt
