---
title: "{{ replace .Name "-" " " | title }}"
creation_date: {{ .Date }}
last_edit_date: {{ .Date }}
draft: false
weight: 1
bookFlatSection: false
bookCollapseSection: true
pub_date: "{{ now.Format "2006-01-02" }}"  # Publication date of the newspaper (YYYY-MM-DD)
newspaper: "The Evening Star"  # e.g., "The Evening Star"
transcriber: "Derek Stevens"  # Credit for transcription
pdf_file: "/pdf/{{ title.Format "2006-01-02-01" }}.pdf"  # Path to the PDF in static/

tags: ["front-page", "historical", "newspaper"]
categories: ["Newspaper Pages"]
---

# {{ .Name }} - Front Page

This is the front page (or section) of the newspaper from [pub_date].

## Embedded PDF
{{</* figure src="[Library of Congress]" caption="PDF scan" */>}}

## Associated Articles
List links to child articles here (Hugo auto-generates menu, but manual for clarity):
- [Article 1 Title](/{{ now.Format "2006-01-02" }}/article1/)
- [Article 2 Title](/{{ now.Format "2006-01-02" }}/article2/)

<!-- Add transcribed text or summaries from the front page here if needed. Child articles will appear in the sidebar menu due to bookCollapseSection. -->
<!-- Note: After creation, replace [PUB_DATE_PLACEHOLDER] with the value from front matter 'pub_date', and [PDF_FILE_PLACEHOLDER] with 'pdf_file'. -->
