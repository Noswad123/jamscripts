#  py ~/Projects/jamscripts/add-hyphens.py "$(obpath "Syllabus/Academics/Bioloy/Bioloy.md")" 
import sys
import os

def add_hyphen_to_file(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()

    with open(file_path, 'w') as f:
        for line in lines:
            stripped_line = line.lstrip()
            if stripped_line and not stripped_line.startswith('-') and not stripped_line.startswith('#'):
                f.write('-'+ ' ' + line.lstrip())
            else:
                f.write(line)

if __name__ == "__main__":
    # Check if at least a file is provided as an argument
    if len(sys.argv) < 2:
        print("Usage: python3 script.py filename")
        sys.exit(1)

    filename = sys.argv[1]
    print(f"File path received: {filename}")
    add_hyphen_to_file(filename)
