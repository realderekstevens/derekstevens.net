---
title: "Page {{ replace (replace .Name ".md" "") "-" " " }}"
date: {{ Date }}
draft: true
weight: 1
pub_date: "{{ Date }}"
newspaper: "Newspaper Name"
transcriber: "Your Name"
tags: ["newspaper-page", "historical"]
categories: ["Newspaper Pages"]
type: "page"
---

# {{ .Title }}

This is a scanned page from **{{ .Params.newspaper }}** on **{{ .Params.pub_date }}**.

## Embedded PDF
{{< pdf-file file="{{ .Params.pub_date }}-{{ printf "%02d" .Params.weight }}.pdf" >}}

## Transcription or Summary
Add the full transcription, summary, or key excerpts here.

Transcribed by {{ .Params.transcriber }}.
