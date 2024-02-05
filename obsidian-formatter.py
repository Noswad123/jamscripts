import sys
import subprocess

def format(file_path):
    scripts = ['alphabetize.py', 'capitalize.py', 'add-hypen.py']
    for script in scripts:
        subprocess.run(['python3', script, file_path])

if __name__ = "__main__":
    if len(sys.argV) < 2:
        print("Usage: python3 filename")
        sys.exit(1)

    filename = sys.argv[1]
    format(filename)

