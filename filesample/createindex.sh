#!/bin/bash

# Output file
output="index.html"

# Function to get human-readable file size
human_readable_size() {
    local size=$1
    local units=("B" "K" "M" "G" "T" "P" "E" "Z" "Y")
    local unit=0

    while (( $(echo "$size > 1024" | bc -l) )); do
        size=$(echo "scale=1; $size / 1024" | bc -l)
        ((unit++))
    done

    printf "%.1f%s\n" $size "${units[$unit]}"
}

# Function to get file size in bytes (compatible with both Linux and macOS)
get_file_size() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        stat -f%z "$1"
    else
        # Linux
        stat -c%s "$1"
    fi
}

# Function to get file extension
get_extension() {
    echo "${1##*.}"
}

# Start writing the HTML file
cat << EOF > "$output"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Directory Index</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            background-color: #fff;
            margin-bottom: 20px;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        li:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        a {
            color: #2980b9;
            text-decoration: none;
            display: block;
            margin-bottom: 10px;
        }
        a:hover {
            color: #3498db;
        }
        .file-icon, .folder-icon {
            margin-right: 10px;
        }
        .folder-icon {
            color: #f39c12;
        }
        .file-icon {
            color: #2ecc71;
        }
        .file-size {
            color: #7f8c8d;
            font-size: 0.8em;
        }
        .preview {
            max-width: 100%;
            margin-top: 10px;
        }
        iframe {
            width: 100%;
            height: 400px;
            border: none;
        }
    </style>
</head>
<body>
    <h1>Directory Index</h1>
    <ul>
EOF

# List all files and directories, sort them
for item in $(ls -A1 | sort); do
    # Skip the index.html file itself
    if [ "$item" != "$output" ]; then
        size=$(human_readable_size $(get_file_size "$item"))
        extension=$(get_extension "$item")
        
        echo "<li>" >> "$output"
        
        # Check if it's a directory
        if [ -d "$item" ]; then
            echo "<span class=\"folder-icon\">📁</span><a href=\"./$item\">$item/</a><span class=\"file-size\">Directory</span>" >> "$output"
        else
            echo "<span class=\"file-icon\">📄</span><a href=\"./$item\">$item</a><span class=\"file-size\">$size</span>" >> "$output"
            
            # Embed content based on file type
            case $extension in
                jpg|jpeg|png|gif)
                    echo "<img src=\"./$item\" alt=\"$item\" class=\"preview\">" >> "$output"
                    ;;
                mp4|webm|ogg)
                    echo "<video src=\"./$item\" controls class=\"preview\">Your browser does not support the video tag.</video>" >> "$output"
                    ;;
                mp3|wav)
                    echo "<audio src=\"./$item\" controls class=\"preview\">Your browser does not support the audio tag.</audio>" >> "$output"
                    ;;
                pdf|html)
                    echo "<iframe src=\"./$item\" class=\"preview\"></iframe>" >> "$output"
                    ;;
            esac
        fi
        
        echo "</li>" >> "$output"
    fi
done

# Finish the HTML file
cat << EOF >> "$output"
    </ul>
</body>
</html>
EOF

echo "index.html has been generated with embedded content previews."