#!/bin/bash

# Absolute path to the directory containing the subdirectories
PARENT_DIR="$HOME/code/shipping/client/src/app/modals"

# Check if the directory exists
if [ -d "$PARENT_DIR" ]; then
	# Navigate to the parent directory
	cd "$PARENT_DIR" || exit

	# Loop through all subdirectories
	for d in */; do
		if [ -d "$d" ]; then # Check if $d is a directory
			echo "Running script in $d"
			cd "$d" || continue # Go to the directory or skip if it fails
			# Execute the Node.js script
			~/Projects/jamscripts/add-index-file.js
			cd .. # Go back to the parent directory
		else
			echo "Skipping $d - not a directory"
		fi
	done
else
	echo "Directory $PARENT_DIR does not exist."
fi
