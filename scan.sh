#!/bin/bash

# Ask user for file format and name
echo "Enter file format (png, jpeg, pdf):"
read format
echo "Enter output file name (without extension):"
read filename

# Validate format
if [[ "$format" != "png" && "$format" != "jpeg" && "$format" != "pdf" ]]; then
    echo "Invalid format. Please use png, jpeg, or pdf."
    exit 1
fi

# Define temp format for PDF conversion
scan_format=$format
if [[ "$format" == "pdf" ]]; then
    scan_format="png" # Scan as PNG first
fi

# Perform the scan and capture output
scan_output=$(scanimage --device "airscan:w0:CANON INC. TS3700 series" --format=$scan_format --output-file=${filename}.$scan_format --progress 2>&1)

# Check for failure in scan output
if echo "$scan_output" | grep -qi "failed"; then
    echo "Scan failed: $scan_output"
    exit 1
fi

# Convert to PDF if needed
if [[ "$format" == "pdf" ]]; then
    magick ${filename}.png ${filename}.pdf
    rm ${filename}.png # Remove temp file
    echo "Scan complete: ${filename}.pdf"
else
    echo "Scan complete: ${filename}.$format"
fi
