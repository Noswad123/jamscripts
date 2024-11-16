import sys
import os

def alphabetize(file_path):
    if not os.path.isfile(file_path):
        print(f"Error: File '{file_path}' not found!")
        sys.exit(1)

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
        for i, (header, items) in enumerate(sorted_headers):
            file.write(header + '\n')
            for item in sorted(items):
                file.write('\t' + item + '\n')
            file.write('\n')

    print(f"File has been alphabetized and overwritten: {file_path}")

if __name__ == "__main__":
    # Check if at least a file is provided as an argument
    if len(sys.argv) < 2:
        print("Usage: python3 alphabetize.py filename")
        sys.exit(1)

    filename = sys.argv[1]
    alphabetize(filename)
