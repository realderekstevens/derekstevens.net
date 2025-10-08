---
title: "{{ replace .Name "-" " " | title }}"
creation_date: {{ .Date }}
last_edit_date: {{ .Date }}
draft: false
weight: 1
bookFlatSection: false
bookCollapseSection: true
pub_date: "{{ now.Format "1929-10-28" }}"  # Publication date of the newspaper (YYYY-MM-DD)
newspaper: "The Evening Star"  # e.g., "The New York Times"
transcriber: "Derek E Stevens"  # Credit for transcription
pdf_file: "/static/pdf/{{ now.Format "1929-10-28-01" }}.pdf"  # Path to the front page of newspaper of PDF in static/

tags: ["front-page", "historical", "newspaper"]
categories: ["Newspaper Pages"]
---

# {{ replace .Name "-" " " | title }} - Front Page

This is the front page (or section) of the newspaper from {{ .Params.pub_date }}.

## Embedded PDF
{{</* figure src="{{ .Params.pdf_file }}" caption="PDF scan" */>}}

## Associated Articles
List links to child articles here (Hugo auto-generates menu, but manual for clarity):
- [Article 1 Title](/{{ now.Format "2006/01/02" }}/article1/)
- [Article 2 Title](/{{ now.Format "2006/01/02" }}/article2/)

<!-- Add transcribed text or summaries from the front page here if needed. Child articles will appear in the sidebar menu due to bookCollapseSection. -->
