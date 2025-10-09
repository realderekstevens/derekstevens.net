+++
title = '28th'
weight = 28
bookCollapseSection = true
date = 2025-10-07
draft = false
tags = ['1929', 'October', 'Stock Market', 'Black Monday']
+++

# STOCKS DEPRESSED IN BEARISH ATTACK

## Market Sags Again Under Heavy Selling Pressure. Leaders Hard Hit.

By the Associated Press.

### New York, October 28.--Deprived of the banking support which many traderse understood had been arranged for last week, the stock market plunged downard in spectacular fashion again today as "bears" renewed their assaults on the market and thousands of weak-ened speculative accounts were thrown overboard. Prices of scores of issues broke 5 to 45 points, with most of the leaders selling below the low levels reached in last Thursday's Record breaking session.

### Trading was again in enormous volume, with the ticker falling an hour behind the market by early afternoon. Total sales crossed the 3,000,000 share mark before mid-day, with indications that the day's total would run well over 8,000,000 shares.

## Day's News Disregarded.

### Indications that bankers might again be called upon to stem the tide of selling were seen in the visit early this afternoon of Charles E. Mitchell, chairman of the National City Bank, the country's largest banking institution, to the offices of J. P. Morgan & Co. Unless the tide of selling is stemmed, other bankers probably will be called into conference.

### With the market undergoing another drastic "cleaning out" process, little attention was paid to the day's news. Nothing happened over the week end to alter the views of President Hoover and leading bankers that funamental business conditions were sound, and that there was no sign of a general recession in industrial activity.

### Directors of the General Regactories Co. today declared an extra dividend of 25 cents and raised the annual rate from $3 to $4. Wall Street is fervently hoping that good news will be forth coming from the quarterly meeting of the United States Steel Corporation after the close of the market tomorrow. Several weeks ago there were rumors of a possible stock split-up or extra dividend on steel, but these gradually disappeared as teh date of the meeting approached.

{{ $data := dict }}
{{ $file := "csv/1929-10-28.csv" }}  {{/* Path relative to data/ */}}
{{ with site.Data.csv["1929-10-28"] }}  {{/* Access via site.Data if in data/ */}}
  {{ $opts := dict "targetType" "slice" "delimiter" "," "comment" "#" "lazyQuotes" true }}
  {{ $data = . | transform.Unmarshal $opts }}
{{ else }}
  {{ errorf "CSV file %q not found" $file }}
{{ end }}

## As HTML Table (Slice Target Type)
<table>
  <thead>
    <tr>
      {{ range index $data 0 }}  {{/* Headers from first row */}}
        <th>{{ . }}</th>
      {{ end }}
    </tr>
  </thead>
  <tbody>
    {{ range $data | after 1 }}  {{/* Skip headers */}}
      <tr>
        {{ range . }}
          <td>{{ . }}</td>
        {{ end }}
      </tr>
    {{ end }}
  </tbody>
</table>

## Filtered and Sorted (Map Target Type)
{{ $opts := dict "targetType" "map" "delimiter" "," }}  {{/* Remarshal as map for filtering */}}
{{ $mapData := site.Data.csv["1929-10-28"] | transform.Unmarshal $opts }}

{{ with sort (where $mapData "Stock" "!=" "") "Close" "desc" }}  {{/* Sort by Close descending */}}
  <ul>
    {{ range . }}
      <li>{{ .Stock }}: Close at {{ .Close }} (Volume: {{ .Volume }})</li>
    {{ end }}
  </ul>
{{ end }}

{{< pdf-file "/pdf/1929-10-28-p15-bond.pdf" >}}
