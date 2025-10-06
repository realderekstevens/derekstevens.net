+++date = '{{ .Date }}'draft = truetitle = '{{ replace .File.ContentBaseName "-" " " | title }}'weight = 20tags = ["article", "newspaper", "transcription"]categories = ["Newspaper Articles"]
Article-specific
pub_date = ""    # Original publication date, e.g., "1920-01-01"newspaper = ""   # E.g., "The New York Times"author = ""      # Original author, if knowntranscriber = "" # Your name or contributortranscription_status = "draft"  # Options: draft, partial, completesource_url = ""  # Link to scan or archive, if available
+++
{{ .Params.title }}
Originally published in {{ .Params.newspaper }} on {{ .Params.pub_date }}

Block quote from the article here.

Transcribed by {{ .Params.transcriber }}. Status: {{ .Params.transcription_status }}
Article Content
Start transcribing the full text here.
Notes
Add transcription notes, context, or issues encountered.
