#! /usr/bin/env zsh

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
	echo "Error: Input directory argument required."
	usage
fi

# Assign arguments to variables
INPUT_DIR=$1
OUTPUT_DIR="$HOME/Library/Fonts/"

# Check if input directory exists
if [ ! -d "$INPUT_DIR" ]; then
	echo "Error: Input directory '$INPUT_DIR' does not exist."
	exit 1
fi

# Check if output directory exists
if [ ! -d "$OUTPUT_DIR" ]; then
	echo "Error: Output directory '$OUTPUT_DIR' does not exist."
	exit 1
fi

# Run the docker command
docker run --rm -v "$INPUT_DIR:/in:Z" -v "$OUTPUT_DIR:/out:Z" nerdfonts/patcher --complete

# Check if the command was successful
if [ $? -eq 0 ]; then
	echo "Nerd Fonts patching completed successfully."
else
	echo "Error: Failed to patch font."
	exit 1
fi
