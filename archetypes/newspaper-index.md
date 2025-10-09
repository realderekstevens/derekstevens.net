---
title: "{{ replace .Name "-" " " | title }} - Newspaper Edition"
date: {{ .Date }}
draft: true
weight: 1
bookFlatSection: false
bookCollapseSection: true
pub_date: "{{ now.Format "2006-01-02" }}"  # Newspaper date (YYYY-MM-DD) - override after creation
newspaper: "Newspaper Name"
tags: ["historical", "newspaper-edition"]
categories: ["Newspaper Dates"]
---

# {{ replace .Name "-" " " | title }} - Overview

Transcriptions and pages from {{ .Params.newspaper }} on {{ .Params.pub_date }}.

## Pages and Articles
{{ range .Pages.ByWeight }}  <!-- Loops over all .md files in this folder, sorted by weight -->
- [{{ .Title }}]({{ .RelPermalink }}) - {{ .Summary | truncate 100 }}  <!-- Link, title, short summary -->
{{ end }}

<!-- Add overall summary or links here. Hugo-book will also show them in sidebar menu. -->
