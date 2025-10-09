---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date | time.Format "2006-01-02" }}
draft: false
weight: 10
pub_date: "{{ $dirParts := split .Dir "/" }}{{ printf "%s-%s-%s" (index $dirParts 1) (index $dirParts 2) (index $dirParts 3) }}"
newspaper: "Newspaper Name"
author: "Original Author"
transcriber: "Your Name"
transcription_status: "draft"
source_url: ""
original_page: "Page {{ replace (replace .BaseFileName "-" " ") "_" " " }}"
continued_on: ""
parent_page: "/{{ $dirParts := split .Dir "/" }}{{ printf "%s/%s/%s/" (index $dirParts 1) (index $dirParts 2) (index $dirParts 3) }}"
tags: ["article", "historical", "newspaper"]
categories: ["Newspaper Articles"]
---

# {{ replace .Name "-" " " | title }}

Originally published in **{{ "<Newspaper Name>" }}** on **{{ $dirParts := split .Dir "/" }}{{ printf "%s-%s-%s" (index $dirParts 1) (index $dirParts 2) (index $dirParts 3) }}** by **{{ "<Author>" }}**.

## Back to Parent Page

[Return to Date Overview]({{ printf "/%s/%s/%s/" (index (split .Dir "/") 1) (index (split .Dir "/") 2) (index (split .Dir "/") 3) }})

---

## Scanned Page PDF

{{< pdf-file "{{ printf "%s-%s-%s-%s.pdf" (index (split .Dir "/") 1) (index (split .Dir "/") 2) (index (split .Dir "/") 3) .BaseFileName }}" >}}

---

## Transcription

Paste the full transcribed text of the article here.

> Block quote from the article here.

Transcribed by {{ "<Your Name>" }}. Status: {{ "<draft | partial | complete>" }}

---

## Notes

Add transcription notes, context, or issues encountered.

---

## Associated Image (optional)

{{</* figure src="/images/{{ printf "%s-%s-%s" (index (split .Dir "/") 1) (index (split .Dir "/") 2) (index (split .Dir "/") 3) }}/{{ replace .Name "-" "_" | lower }}.webp" caption="Scan of the article" */>}}
