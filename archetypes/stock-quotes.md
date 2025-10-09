---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
weight: 20
stock_date: "{{ .Date.Format "2006-01-02" }}"
company: ""
source: ""
data_format: "csv" # "table" or "csv"
tags: ["stocks", "finance", "historical"]
categories: ["Stock Data"]
type: "stocks"
---

# Stock Quotes – {{ .Params.stock_date }}

{{< stock-data file="{{ .Params.stock_date }}.csv" format="{{ .Params.data_format }}" >}}

Add notes or commentary here about market movements or context.
