---
title: "{{ $pageNum := replace .BaseFileName ".md" "" }}{{ printf "Page %s" $pageNum }}"  # Dynamically sets title to 'Page XX' from filename (e.g., 14.md -> Page 14)
date: {{ .Date }}
draft: true
weight: {{ $pageNumInt := int $pageNum }}{{ $pageNumInt }}  # Sets weight to page number for sorting (e.g., 14)
pub_date: "{{ $dirParts := split .Dir "/" }}{{ printf "%s-%s-%s" (index $dirParts 1) (index $dirParts 2) (index $dirParts 3) }}"  # Extracts date from path (1929/10/28 -> 1929-10-28)
newspaper: "Newspaper Name"  # e.g., "The Evening Star"
transcriber: "Your Name"  # Transcription credit
tags: ["newspaper-page", "historical"]
categories: ["Newspaper Pages"]
---

# {{ .Title }} - Newspaper Page

This is page {{ $pageNum }} from {{ .Params.newspaper }} dated {{ .Params.pub_date }}.

## Embedded PDF
{{</* pdf-file "{{ .Params.pub_date }}-{{ printf "%02d" $pageNumInt }}.pdf" */>}}  <!-- Dynamically sets to "1929-10-28-14.pdf" (with leading zero if needed) -->

## Transcription or Summary
Add full transcription, key excerpts, or summaries here.

## Associated Articles
- [Article 1](/{{ .Params.pub_date }}/article-slug/)  # Manual links to articles in same folder; or use range if needed

Transcribed by {{ .Params.transcriber }}.
