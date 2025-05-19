#!/bin/bash

# Check if file is provided as argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <html_file>"
    exit 1
fi

HTML_FILE="$1"

# Check if file exists
if [ ! -f "$HTML_FILE" ]; then
    echo "Error: File '$HTML_FILE' not found."
    exit 1
fi

# Create CSS content in a separate file for better handling
TMP_CSS=$(mktemp)
cat > "$TMP_CSS" << 'ENDCSS'
    @media print {
        /* Reset the grid layout for print */
        body {
            display: block !important;
            margin: 20mm 10mm !important;
        }

        /* Make sections block level for print */
        section {
            display: block !important;
            width: 100% !important;
            clear: both !important;
            /* Set up a two-column layout */
            position: relative !important;
        }

        /* Style the section titles */
        h3 {
            width: 25% !important;
            float: left !important;
            clear: left !important;
            text-align: right !important;
            padding-right: 1em !important;
        }

        /* Style the content area */
        .stack {
            width: 75% !important;
            float: right !important;
            clear: right !important;
        }

        /* Prevent article breaks */
        article {
            break-inside: avoid !important;
            page-break-inside: avoid !important;
            display: block !important;
            overflow: visible !important;
            width: 100% !important;
            margin-bottom: 1em !important;
        }

        /* Clear fix for floating elements */
        section::after {
            content: "" !important;
            display: table !important;
            clear: both !important;
        }

        /* Fix masthead layout */
        .masthead {
            display: block !important;
            break-inside: avoid !important;
            page-break-inside: avoid !important;
            padding: 2em 0 !important; /* Reduced padding */
            margin-bottom: 2em !important;
        }

        /* Layout masthead contents */
        .masthead img {
            float: left !important;
            width: 25% !important; /* Match section title width */
            max-height: 150px !important;
            height: auto !important;
        }

        .masthead > div,
        .masthead > article,
        .masthead > ul {
            float: right !important;
            width: 75% !important; /* Match content width */
            clear: right !important;
        }

        /* Adjust icon list for print */
        .icon-list {
            flex-direction: column !important;
            margin-top: 1em !important;
        }

        /* Clear fix for masthead */
        .masthead::after {
            content: "" !important;
            display: table !important;
            clear: both !important;
        }
    }
ENDCSS

# Create a temporary file for the output
TEMP_FILE=$(mktemp)

# Check if the file contains a </style> tag
if grep -q "</style>" "$HTML_FILE"; then
    # Use awk for more reliable handling of multiline insertions
    awk '
    {
        if ($0 ~ /<\/style>/) {
            system("cat '"$TMP_CSS"'")
            print $0
        } else {
            print $0
        }
    }
    ' "$HTML_FILE" > "$TEMP_FILE"

    # Move the temporary file back to the original
    mv "$TEMP_FILE" "$HTML_FILE"
    echo "CSS successfully injected into $HTML_FILE"
else
    rm "$TEMP_FILE"
    echo "Error: Failed to find </style> tag in the file."
    exit 1
fi

# Clean up
rm "$TMP_CSS"
