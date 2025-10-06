+++date = '{{ .Date }}'draft = truetitle = '{{ replace .File.ContentBaseName "-" " " | title }}'weight = 1tags = ["newspaper", "front-page", "historical"]categories = ["Newspaper Front Pages"]
Front page specific
pub_date = ""    # Original publication date, e.g., "1963-11-22"newspaper = ""   # E.g., "The New York Times"edition = ""     # E.g., "Late City Edition"headlines = []   # List of major headlines, e.g., ["Headline 1", "Headline 2"]source_url = ""  # Link to original scan or archivetranscriber = "" # Name of contributortranscription_status = "draft"  # Options: draft, partial, complete
+++
{{ .Params.title }} - {{ .Params.newspaper }} ({{ .Params.pub_date }})
{{ .Params.edition }}
Major Headlines
{{ range .Params.headlines }}

{{ . }}{{ end }}

Front Page Summary
Summarize the front page content here, including key articles, images, or layout notes.
Transcription Notes
Add any transcription challenges or context (e.g., image quality, missing sections).
Transcribed by {{ .Params.transcriber }}. Status: {{ .Params.transcription_status }}
