# Readme

## Page break

This article helped me to deal with page break, but I don't know what I did with it to solve the page break issue...
https://dev.to/amruthpillai/avoiding-awkward-element-breaks-in-print-html-5goe

Add this to the created HTML to fix the page break issue

```
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
```