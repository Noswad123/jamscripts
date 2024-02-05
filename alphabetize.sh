#!/bin/bash

alphabetize() {
  local file="$1"
  
  python3 -c "
import re

def sort_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    headers = {}
    current_header = ''
    for line in lines:
        if not line.startswith('\t'):
            current_header = line.strip()
            headers[current_header] = []
        else:
            headers[current_header].append(line.strip())

    sorted_headers = sorted(headers.items())

    with open(file_path, 'w') as file:
        for header, items in sorted_headers:
            file.write(header + '\n')
            for item in sorted(items):
                file.write('\t' + item + '\n')

sort_file('\$file')
"
}

# Check if at least a file is provided as an argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 filename"
  exit 1
fi

filename="$1"

# Check if the file exists
if [ ! -f "$filename" ]; then
  echo "Error: File '$filename' not found!"
  exit 1
fi

alphabetize "$filename"

echo "File has been alphabetized and overwritten: $filename"