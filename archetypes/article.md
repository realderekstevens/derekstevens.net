+++
date = '{{ .Date }}'
draft = false
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
weight = 20
tags = ["article", "newspaper", "transcription"]
categories = ["Newspaper Articles"]
pub_date = ""    # Original publication date, e.g., "1920-01-01"
newspaper = "North Starr"   # E.g., "The New York Times"
author = ""      # Original author, if known
transcriber = "Derek E Stevens" # Your name or contributor
transcription_status = "draft"  # Options: draft, partial, complete
source_url = ""  # Link to scan or archive, if available
+++

{{ .Params.title }}
Originally published in {{ .Params.newspaper }} on {{ .Params.pub_date }}

Block quote from the article here.

Transcribed by {{ .Params.transcriber }}. Status: {{ .Params.transcription_status }}

Article Content

Start transcribing the full text here.

Notes: Add transcription notes, context, or issues encountered.
