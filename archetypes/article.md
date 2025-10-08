---
date = '{{ .Date }}'
draft = false
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
weight = '{{ .Page }}' # Adjust weight as it appears from top-left down to bottom-right
tags = ["article", "newspaper", "transcription", "historical"]
categories = ["Newspaper Articles", "Finance", "USA"]
pub_date = '{{ .Date }}'    # Original publication date, e.g., '1920-04-20'
newspaper = "Evening Star"   # E.g., "New York Times"; Make sure not to use 'the' in names because of redundancy in search engine
author = "Wheeler D Johnson"      # Original author, if known please include middle initial if possible, no period after middle initial
transcriber = "Derek E Stevens" # Your name or contributor
transcription_status = "draft"  # Options: draft, partial, complete
source_url = ""  # Link to scan or archive, if available
website_page: "01"  # e.g. "03" or "44" make sure to use leading '0' if single digit
continued_on: "13" # e.g. "13" if the article is continued onto another digital page, please use the pagination of the digital double-digit page and not the referenced (E.g. "A-13" or "B-13")
---

{{ .Params.title }}
Originally published in {{ .Params.newspaper }} on {{ .Params.pub_date }}

Block quote from the article here.

Transcribed by {{ .Params.transcriber }}. Status: {{ .Params.transcription_status }}

Article Content

Start transcribing the full text here.

Notes: Add transcription notes, context, or issues encountered.






title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true



# {{ replace .Name "-" " " | title }}

{{</* hint info */>}}
Transcriber's Note: Any edits or clarifications.
{{</* /hint */>}}

## Associated Image (if available)
{{</* figure src="/static/{{ now.Format "2006/01/02" }}/article-slug.webp" caption="Scan of the article" */>}}
