+++
date = '{{ .Date }}'
draft = true
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
weight = 10
tags = ["stocks", "finance", "historical"]
categories = ["Stock Data"]

# Specific to stock numbers
stock_date = ""  # E.g., "1929-10-29" for the specific date or start of range
company = ""    # E.g., "General Electric"
source = ""     # E.g., "New York Times Financial Section"
data_format = "table"  # Options: table, json, csv

+++

## Stock Data for {{ .Params.title }}

| Date       | Open  | High  | Low   | Close | Volume |
|------------|-------|-------|-------|-------|--------|
| YYYY-MM-DD | 0.00  | 0.00  | 0.00  | 0.00  | 0      |

*Source: {{ .Params.source }}*

Add notes or analysis here.
