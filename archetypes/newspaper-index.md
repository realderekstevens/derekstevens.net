---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: false
weight: 1
bookFlatSection: false
bookCollapseSection: true
pub_date: "{{ now.Format "1929-10-28" }}"  # Publication date of the newspaper (YYYY-MM-DD)
newspaper: "The Evening Star"  # e.g., "The New York Times"
transcriber: "Derek E Stevens"  # Credit for transcription
pdf_file: "/static/pdf/{{ now.Format "1929/10/28/01/" }}.pdf"  # Path to the front page of newspaper of PDF in static/
tags: ["front-page", "historical", "newspaper"]
---

# {{ replace .Name "-" " " | title }} - Front Page

This is the front page of the newspaper from {{ .Params.pub_date }}.

## Embedded PDF
{{</* figure src="{{ .Params.pdf_file }}" caption="Front page PDF scan" */>}}

## Associated Articles
- [Article 1 Title](/path/to/article1/)
- [Article 2 Title](/path/to/article2/)

<!-- Add transcribed text or summaries from the front page here if needed -->
