---
title: "{{ replace .Name "-" " " | title }}"
creation_date: {{ .Date }}
last_edit_date: {{ .Date }}
draft: false
weight: 1
bookFlatSection: false
bookCollapseSection: true
pub_date: "{{ now.Format "2006-01-02" }}"  # Publication date of the newspaper (YYYY-MM-DD)
newspaper: "Newspaper Name"  # e.g., "The Evening Star"
transcriber: "Your Name"  # Credit for transcription
pdf_file: "/images/{{ now.Format "2006/01/02" }}/front-page.pdf"  # Path to the PDF in static/

tags: ["front-page", "historical", "newspaper"]
categories: ["Newspaper Pages"]
---

# {{ replace .Name "-" " " | title }} - Front Page

This is the front page (or section) of the newspaper from [PUB_DATE_PLACEHOLDER].

## Embedded PDF
{{</* figure src="{{ .Params.pdf_file }}" caption="PDF scan" */>}}

## Associated Articles
List links to child articles here (Hugo auto-generates menu, but manual for clarity):
- [Article 1 Title](/{{ now.Format "2006/01/02" }}/article1/)
- [Article 2 Title](/{{ now.Format "2006/01/02" }}/article2/)

<!-- Add transcribed text or summaries from the front page here if needed. Child articles will appear in the sidebar menu due to bookCollapseSection. -->

<!-- Note: Replace [PUB_DATE_PLACEHOLDER] with the actual date after creation. -->
