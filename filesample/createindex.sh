#!/bin/bash

# Output file
output="index.html"

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
            margin-bottom: 10px;
            padding: 10px 15px;
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
        # Check if it's a directory
        if [ -d "$item" ]; then
            echo "        <li><span class=\"folder-icon\">📁</span><a href=\"$item\">$item/</a></li>" >> "$output"
        else
            echo "        <li><span class=\"file-icon\">📄</span><a href=\"$item\">$item</a></li>" >> "$output"
        fi
    fi
done

# Finish the HTML file
cat << EOF >> "$output"
    </ul>
</body>
</html>
EOF

echo "index.html has been generated with a beautiful design."

python3 -m http.server