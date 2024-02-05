import sys
import os

def capitalize_first_letter(file_path):
        # Check if the file exists
    if not os.path.isfile(file_path):
        print(f"Error: File '{file_path}' not found!")
        sys.exit(1)

    with open(file_path, 'r') as file:
        lines = file.readlines()

    with open(file_path, 'w') as file:
        for line in lines:
            # Find the index of the first alphabetic character
            index = next((i for i, c in enumerate(line) if c.isalpha()), None)
            
            if index is not None:
                file.write(line[:index] + line[index].upper() + line[index+1:])
            else:
                file.write(line)

    print(f"File has been capitalized and overwritten: {file_path}")

if __name__ == "__main__":
    # Check if at least a file is provided as an argument
    if len(sys.argv) < 2:
        print("Usage: python3 script.py filename")
        sys.exit(1)

    filename = sys.argv[1]
    capitalize_first_letter(filename)
