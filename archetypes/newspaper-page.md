---
title: "{{ replace (replace .Name ".md" "") "-" " " }}"
date: {{ .Date }}
draft: true
weight: 1
pub_date: "{{ .Date }}"
newspaper: "Newspaper Name"
transcriber: "Your Name"
tags: ["newspaper-page", "historical"]
categories: ["Newspaper Pages"]
type: "page"
---

# {{ replace (replace .Name ".md" "") "-" " " }}

This is a scanned page from **Newspaper Name** on **{{ .Date }}**.

## Embedded PDF
{{< pdf-file file="{{ .Date }}-{{ printf "%02d" .Params.weight }}.pdf" >}}

## Transcription or Summary
Add the full transcription, summary, or key excerpts here.

Transcribed by Your Name.
