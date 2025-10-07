+++
date = '{{ .Date }}'
draft = true
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
weight = 10
tags = ["stocks", "finance", "historical"]
categories = ["Stock Data"]

# Specific to stock numbers
stock_date = ""  # E.g., "1929-10-28"
company = ""    # E.g., "General Electric"
source = ""     # E.g., "New York Times Financial Section"
data_format = "table"  # Options: table, json, csv

+++

## Stock Data for {{ .Params.title }}

# Option 1: Inline Table (Manual Entry or Small Data)
| Date       | Open  | High  | Low   | Close | Volume |
|------------|-------|-------|-------|-------|--------|
| {{ .Params.stock_date }} | 0.00  | 0.00  | 0.00  | 0.00  | 0      |

*Source: {{ .Params.source }}*

# Option 2: Unmarshal from Data Folder CSV (For Larger Datasets)
{{ $file := printf "csv/%s.csv" .Params.stock_date }}  {{/* e.g., data/csv/1929-10-28.csv */}}
{{ $opts := dict "targetType" "map" "delimiter" "," }}
{{ $data := site.Data.csv (printf "%s" .Params.stock_date) | transform.Unmarshal $opts }}

{{ with sort (where $data "Company" .Params.company) "Close" "desc" }}
  <ul>
    {{ range . }}
      <li>{{ .Stock }}: Close at {{ .Close }} (Volume: {{ .Volume }})</li>
    {{ end }}
  </ul>
{{ else }}
  No data found for {{ .Params.stock_date }}.
{{ end }}

# Option 3: Unmarshal from Page Resource CSV (Bundle-Specific)
{{ $csvPath := printf "%s.csv" .Params.stock_date }}
{{ with .Resources.Get $csvPath }}  {{/* If CSV is in the same page bundle */}}
  {{ $data = . | transform.Unmarshal (dict "targetType" "slice") }}
  <table>
    <thead><tr>{{ range index $data 0 }}<th>{{ . }}</th>{{ end }}</tr></thead>
    <tbody>{{ range $data | after 1 }}<tr>{{ range . }}<td>{{ . }}</td>{{ end }}</tr>{{ end }}</tbody>
  </table>
{{ end }}

Add notes or analysis here.
