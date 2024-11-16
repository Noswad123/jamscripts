#!/usr/bin/env python3

import subprocess

def get_clipboard_data():
    """Get the current clipboard data using pbpaste."""
    process = subprocess.Popen(['pbpaste'], stdout=subprocess.PIPE)
    data, _ = process.communicate()
    return data.decode('utf-8')

def set_clipboard_data(data):
    """Set the clipboard data using pbcopy."""
    process = subprocess.Popen(['pbcopy'], stdin=subprocess.PIPE)
    process.communicate(input=data.encode('utf-8'))

def process_data(data):
    lines = data.splitlines()
    return ','.join(line.strip() for line in lines if line.strip())

def process_file(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        lines = []
        for line in infile:
            lines.append(line.strip())
            if len(lines) == 1000:
                outfile.write(','.join(lines) + '\n')
                lines = []

        # Write any remaining lines if the total number of lines is not a multiple of 100
        if lines:
            outfile.write(','.join(lines) + '\n')

def main():
    copy_data = get_clipboard_data()
    processed_data = process_data(copy_data)
    set_clipboard_data(processed_data)



if __name__ == "__main__":
    main()
