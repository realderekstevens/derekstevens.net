---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
weight: 10  # Increment for each article in the bundle (e.g., 10, 20)
pub_date: "{{ now.Format "2006-01-02" }}"  # Original publication date, e.g., '1929-10-28'
newspaper: "Newspaper Name"  # e.g., "The Evening Star"
author: "Original Author"  # Original author, if known (include middle initial without period)
transcriber: "Your Name"  # Credit for transcription
transcription_status: "draft"  # Options: draft, partial, complete
source_url: ""  # Link to scan or archive, if available
original_page: "Page X"  # e.g., "Page 1" or "Continued on Page 14" (use digital pagination, leading zero for single digits)
continued_on: ""  # e.g., "13" if continued (digital page number)
parent_page: "/path/to/parent/newspaper-page/"  # Relative link to the parent _index.md (e.g., "/1929/10/28/01/")
tags: ["article", "historical", "newspaper"]
categories: ["Newspaper Articles"]
---

# {{ replace .Name "-" " " | title }}

Originally published in {{ .Params.newspaper }} on {{ .Params.pub_date }} by {{ .Params.author }}.

## Back to Parent Page
[Return to Front Page]({{ .Params.parent_page }})

## Transcription
Paste the full transcribed text of the article here.

> Block quote from the article here.

Transcribed by {{ .Params.transcriber }}. Status: {{ .Params.transcription_status }}

## Notes
Add transcription notes, context, or issues encountered.

## Associated Image (if available)
{{</* figure src="/images/{{ now.Format "2006/01/02" }}/{{ replace .Name "-" "_" | lower }}.webp" caption="Scan of the article" */>}}
