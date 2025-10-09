+++
title = "Stock Market Crash - October 29, 1929"
date = 2025-10-07
draft = false
tags = ["1929", "October", "Stock Market", "Black Monday"]
+++
# Stock Market Crash - October 28, 1929

# STOCKS DEPRESSED IN BEARISH ATTACK
## Market Sags Again Under Heavy Selling Pressure. Leaders Hard Hit.
*By the Associated Press.*

## Day’s News Disregarded.
### Directors of the General Refractories Co. today declared an extra dividend of 25 cents and raised the annual rate from $3 to $4. Wall Street is fervently hoping that good news will be forthcoming from the quarterly meeting of the United States Steel Corporation after the close of the market tomorrow. Several weeks ago there were rumors of a possible stock split-up or extra dividend on steel, but these gradually disappeared as the date of the meeting approached.

{{ $data := dict }}
{{ $file := "csv/1929-10-28.csv" }} {{/* Path relative to data/ */}}
{{ with site.Data.csv["1929-10-28"] }}
  {{ $opts := dict "targetType" "slice" "delimiter" "," "comment" "#" "lazyQuotes" true }}
  {{ $data = . | transform.Unmarshal $opts }}
{{ else }}
  {{ errorf "CSV file %q not found" $file }}
{{ end }}

## As HTML Table (Slice Target Type)
<table>
  <thead>
    <tr>
      {{ range index $data 0 }} {{/* Headers from first row */}}
        <th>{{ . }}</th>
      {{ end }}
    </tr>
  </thead>
  <tbody>
    {{ range $data | after 1 }} {{/* Skip headers */}}
      <tr>
        {{ range . }}
          <td>{{ . }}</td>
        {{ end }}
      </tr>
    {{ end }}
  </tbody>
</table>

## Filtered and Sorted (Map Target Type)
{{ $opts := dict "targetType" "map" "delimiter" "," }}
{{ $mapData := site.Data.csv["1929-10-28"] | transform.Unmarshal $opts }}
{{ with sort (where $mapData "Stock" "!=" "") "Close" "desc" }}
  <ul>
    {{ range . }}
      <li>{{ .Stock }}: Close at {{ .Close }} (Volume: {{ .Volume }})</li>
    {{ end }}
  </ul>
{{ end }}

{{< pdf-file "/pdf/1929-10-28-p4.pdf" >}}

{{ if .Params.BookComments }}
  {{ partial "comments" . }}
{{ end }}
