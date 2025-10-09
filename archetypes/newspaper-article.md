---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
weight: 10  # Increment for each article (e.g., 10, 20); higher than pages for sorting below them
pub_date: "{{ $dirParts := split .Dir "/" }}{{ printf "%s-%s-%s" (index $dirParts 1) (index $dirParts 2) (index $dirParts 3) }}"  # Extracts date from path (1929/10/28 -> 1929-10-28)
newspaper: "Newspaper Name"  # e.g., "The Evening Star"
author: "Original Author"  # Original author, if known
transcriber: "Your Name"  # Transcription credit
transcription_status: "draft"  # Options: draft, partial, complete
source_url: ""  # Link to scan or archive
original_page: "Page X"  # e.g., "Page 1" or "Continued on Page 14"
continued_on: ""  # e.g., "13" if continued
parent_page: "/{{ .Params.pub_date }}/"  # Link back to date overview (_index.md)
tags: ["article", "historical", "newspaper"]
categories: ["Newspaper Articles"]
---

# {{ replace .Name "-" " " | title }}

Originally published in {{ .Params.newspaper }} on {{ .Params.pub_date }} by {{ .Params.author }}.

## Back to Parent Page
[Return to Date Overview]({{ .Params.parent_page }})

## Transcription
Paste the full transcribed text of the article here.

> Block quote from the article here.

Transcribed by {{ .Params.transcriber }}. Status: {{ .Params.transcription_status }}

## Notes
Add transcription notes, context, or issues encountered.

## Associated Image (if available)
{{</* figure src="/images/{{ .Params.pub_date }}/{{ replace .Name "-" "_" | lower }}.webp" caption="Scan of the article" */>}}
