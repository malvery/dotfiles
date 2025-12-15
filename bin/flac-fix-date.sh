#!/bin/bash

for f in **/*.flac; do
    if [ -f "$f" ]; then
        echo "Processing file: $f"

        full_date=$(metaflac --show-tag="DATE" "$f" | cut -d'=' -f2)

        if [ -n "$full_date" ]; then
            year=$(echo "$full_date" | cut -c1-4)

            # Check if a valid 4-digit year was extracted
            if [[ "$year" =~ ^[0-9]{4}$ ]]; then
                echo "  Found date: $full_date, extracting year: $year"

                metaflac --remove-tag="DATE" "$f"
                metaflac --set-tag="DATE=${year}" "$f"

                echo "  Updated YEAR field to $year"
            else
                echo "  Could not extract a valid 4-digit year from $full_date"
            fi
        else
            echo "  No TDRC/DATE tag found to process."
        fi
    fi
done

echo "Finished processing all files."
