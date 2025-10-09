---
title: "{{ replace .Name "-" " " | title }} - Newspaper Edition"
date: {{ .Date }}
draft: false
weight: 1
newspaper: "Newspaper Name"
pub_date: "{{ .Date }}"
tags: ["historical", "newspaper-edition"]
categories: ["Newspaper Dates"]
type: "newspaper-index"
---

# {{ replace .Name "-" " " | title }} - Newspaper Edition

Transcriptions and pages from **Newspaper Name** on **{{ now.Format "2006-01-02" }}**.

---

## Articles
{{< list-content type="article" >}}

## Pages
{{< list-content type="page" >}}

## Stock Data
{{< list-content type="stocks" >}}

---

_Add an editorial summary or notes here._
