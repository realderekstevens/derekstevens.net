---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: false
weight: 10
pub_date: "{{ .Date }}"
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

Originally published in **Newspaper Name** on **{{ .Date | time.Format "2006-01-02" }}**.

[Return to Edition Overview](../)

---

## Scanned Page PDF

{{< pdf-file file="{{ .Date | time.Format "2006-01-02" }}-{{ .File.BaseFileName }}.pdf" >}}

---

## Transcription

Paste the full transcribed text of the article here.

> Example block quote from article text.

Transcribed by Your Name. Status: draft

---

## Notes

Add contextual or editorial notes here.

---

## Associated Image (optional)

{{< figure src="/images/{{ .Date | time.Format "2006-01-02" }}/{{ .File.BaseFileName }}.webp" caption="Scan of the article" >}}
