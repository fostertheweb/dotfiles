#!/usr/bin/env fish

# Check if the correct number of arguments is provided
if test (count $argv) -ne 1
    echo "Error: Input directory argument required."
    exit 1
end

# Assign arguments to variables
set INPUT_DIR $argv[1]
set OUTPUT_DIR "$HOME/Library/Fonts/"

# Check if input directory exists
if not test -d "$INPUT_DIR"
    echo "Error: Input directory '$INPUT_DIR' does not exist."
    exit 1
end

# Check if output directory exists
if not test -d "$OUTPUT_DIR"
    echo "Error: Output directory '$OUTPUT_DIR' does not exist."
    exit 1
end

# Run the docker command
docker run --rm -v "$INPUT_DIR:/in:Z" -v "$OUTPUT_DIR:/out:Z" nerdfonts/patcher --complete

# Check if the command was successful
if test $status -eq 0
    echo "Nerd Fonts patching completed successfully."
else
    echo "Error: Failed to patch font."
    exit 1
end
