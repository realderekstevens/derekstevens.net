https://derekstevens.net

[![Hugo](https://img.shields.io/badge/Hugo-v0.151.0-blue)](https://gohugo.io)

├── archetypes/                  # Content scaffolds (good for consistency)
│   ├── articles.md              # Article transcriptions
│   └── stock-numbers.md         # Stock data pages
├── content/                     # Markdown content (date-based; multilingual? Not explicit)
│   └── YYYY/                    # e.g., 1963/
│       └── MM/                  # e.g., 11/
│           └── DD/              # e.g., 22/
│               ├── page_1.md    # Front page (e.g., kennedy-obituary.md)
│               └── articles/    # Sub-articles
│                   └── *.md
├── data/                        # Structured data (expandable for stocks/transcribers)
│   ├── <YYYY-MM-DD-stocks.csv>  # e.g., 1963-11-22-stocks.csv (stock market data)
│   └── transcribers/            # Contributor metadata
│       ├── derek-stevens.json   # Personal links, email, crypto
│       └── example.json         # Template for submitters
├── static/                      # Assets (legal scans/PDFs; good for organization)
│   └── images/                  # Date-specific
│       └── YYYY/MM/DD/          # e.g., 1963/11/22/
│           ├── front-page.webp  # Optimized images
│           ├── filename-01.pdf  # Scans (PDFs referenced in MD)
│           └── filename-02.webp
├── themes/                      # Hugo Book theme (vendored submodule)
│   └── hugo-book/               # Layouts, CSS/JS for docs-style site
├── config.toml (or hugo.toml)   # Site config (inferred; theme, permalinks, multilingual?)
├── README.md                    # Excellent contrib guide (rules, tags, deployment)
└── .gitignore                   # Likely ignores .env, public/, etc.

This is a simple website for transcribing historical newspapers, focusing on front pages, articles, and stock market data from key dates (like November 22, 1963, when Kennedy was shot). 

No ads, no trackers, just pure history. Built with Hugo and the Book theme for a clean, searchable archive.

Submit transcriptions to get credit. Join us to preserve the past!

Ways to Contribute:

- Transcribe a newspaper front page, article, or stock data.
- Email me a high-quality image of a newspaper scan (if you have legal access to it).
- Fix errors in transcriptions or improve existing content.

Rules for Submission:

- Model submissions after archetypes in archetypes/ (articles.md, stock-numbers.md).
- Place files in content/YYYY/MM/DD/ (e.g., content/1963/11/22/page_1.md for a front page).
- File names use hyphens (-), not underscores or spaces (e.g., kennedy-obituary.md).
- Transcriptions must be accurate and based on real scans (e.g., from newspapers.com or libraries). No fictional content or guesses.
- Include metadata in front matter: pub_date, newspaper, transcriber, etc.
- Don’t include images unless (1) you have permission to use them, and (2) they’re clear and relevant. Images go in static/images/YYYY/MM/DD/ (e.g., static/images/1963/11/22/front-page.webp).
- Use .pdf format. No stock images or low-quality scans.
- Files must end with a newline (\n). Linux does this automatically; Windows users, check your editor.
- If adding stock data, use scv in data/<YYYY-MM-DD-stocks.csv>.
- If you mess these up, I’ll close your pull request, and you’ll need to resubmit. I’m not fixing sloppy submissions.

You can add a JSON file with your info in data/transcribers/your-name.json (e.g., data/transcribers/derek-stevens.json). Include: website, email, or crypto addresses (btc, xmr, eth). See data/transcribers/example.json for a template.
Tags

Add tags to your submission’s front matter (e.g., tags = ["newspaper", "kennedy", "1963"]). Reuse existing tags when possible. Use historical for all transcriptions and front-page, article, or stocks for specific types.
Images

Images go in static/images/YYYY/MM/DD/ (e.g., static/images/1963/11/22/page_1.pdf). Reference images in Markdown with /images/YYYY/MM/DD/filename.webp.

Each front page or article can have one main image.
Additional images (e.g., for article details) should be numbered: filename-01.webp, filename-02.webp, etc.
Only include images you’ve legally sourced or scanned yourself. No internet grabs.

Submit a pull request:
git add .
git commit -m "Add transcription for 1963-11-22 front page"
git push origin main

Fork the repo if you’re not a collaborator and create a PR on GitHub.


Deployment
The site runs on a Debian 13 VPS with Nginx, hosted by Cloudzy. 
A cron job pulls updates every 30 minutes and rebuilds the site. 
Once your PR is merged, changes go live automatically.

License:

All content is in the public domain. By submitting, you waive ownership but can take credit in the transcriber field or your data/transcribers/your-name.json file.
Contact
Open an issue on GitHub or email derek@derekstevens.net for questions.

## Preserving history, one page at a time.
