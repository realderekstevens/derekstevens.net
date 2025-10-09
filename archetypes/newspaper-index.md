---
title: "{{ replace .Name "-" " " | title }} - Newspaper Edition"
date: {{ .Date }}
draft: false
weight: 1
newspaper: "Newspaper Name"
pub_date: "{{ .Date.Format "2006-01-02" }}"
tags: ["historical", "newspaper-edition"]
categories: ["Newspaper Dates"]
type: "newspaper-index"
---

# {{ .Title }}

Transcriptions and pages from **{{ .Params.newspaper }}** on **{{ .Params.pub_date }}**.

---

## Articles
{{< list-content type="article" >}}

## Pages
{{< list-content type="page" >}}

## Stock Data
{{< list-content type="stocks" >}}

---

_Add an editorial summary or notes here._
