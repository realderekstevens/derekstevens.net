---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: false
weight: 10
pub_date: "{{ now.Format "2006-01-02" }}"
newspaper: "Newspaper Name"
author: "Original Author"
transcriber: "Your Name"
transcription_status: "draft"
source_url: ""
original_page: ""
continued_on: ""
tags: ["article", "historical", "newspaper"]
categories: ["Newspaper Articles"]
type: "article"
---

# {{ replace .Name "-" " " | title }}

Originally published in **{{ .newspaper }}** on **{{ .pub_date }}**.

[Return to Edition Overview](../)

---

## Scanned Page PDF

{{< pdf-file file="{{ .pub_date }}-{{ .File.BaseFileName }}.pdf" >}}

---

## Transcription

Paste the full transcribed text of the article here.

> Example block quote from article text.

Transcribed by {{ .transcriber }}. Status: {{ .transcription_status }}

---

## Notes

Add contextual or editorial notes here.

---

## Associated Image (optional)

{{< figure src="/images/{{ .pub_date }}/{{ .File.BaseFileName }}.webp" caption="Scan of the article" >}}
