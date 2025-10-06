https://derekstevens.net

This is a simple website for transcribing historical newspapers, focusing on front pages, articles, and stock market data from key dates (like November 22, 1963, when Kennedy was shot). 

No ads, no trackers, just pure history. Built with Hugo and the Book theme for a clean, searchable archive.

Submit transcriptions to get credit. Join us to preserve the past!

Ways to Contribute:

- Transcribe a newspaper front page, article, or stock data.
- Email me a high-quality image of a newspaper scan (if you have legal access to it).
- Fix errors in transcriptions or improve existing content.

Rules for Submission

Model submissions after archetypes in archetypes/ (newspaper-front-page.md, articles.md, stock-numbers.md).
Place files in content/YYYY/MM/DD/ (e.g., content/1963/11/22/page_1.md for a front page).
File names use hyphens (-), not underscores or spaces (e.g., kennedy-obituary.md).
Transcriptions must be accurate and based on real scans (e.g., from newspapers.com or libraries). No fictional content or guesses.
Include metadata in front matter: pub_date, newspaper, transcriber, etc.
Don’t include images unless (1) you have permission to use them, and (2) they’re clear and relevant. Images go in static/images/YYYY/MM/DD/ (e.g., static/images/1963/11/22/front-page.webp). Use .webp format, ideally under 100KB. No stock images or low-quality scans.
Files must end with a newline (\n). Linux does this automatically; Windows users, check your editor.
If adding stock data, use JSON in data/YYYY/MM/DD/stocks.json or tables in Markdown.

If you mess these up, I’ll close your pull request, and you’ll need to resubmit. I’m not fixing sloppy submissions.
You can add a JSON file with your info in data/transcribers/your-name.json (e.g., data/transcribers/derek-stevens.json). Include: website, email, or crypto addresses (btc, xmr, eth). See data/transcribers/example.json for a template.
Tags
Add tags to your submission’s front matter (e.g., tags = ["newspaper", "kennedy", "1963"]). Reuse existing tags when possible. Use historical for all transcriptions and front-page, article, or stocks for specific types.
Images
Images go in static/images/YYYY/MM/DD/ (e.g., static/images/1963/11/22/front-page.webp). Use .webp for small file sizes. Reference images in Markdown with /images/YYYY/MM/DD/filename.webp.

Each front page or article can have one main image.
Additional images (e.g., for article details) should be numbered: filename-01.webp, filename-02.webp, etc.
Only include images you’ve legally sourced or scanned yourself. No internet grabs.

Getting Started

Clone the repo:
git clone https://github.com/realderekstevens/derekstevens.net.git
cd derekstevens.net


Install Hugo and submodules:
sudo apt install hugo  # Or download from gohugo.io
git submodule update --init --recursive


Create content with Hugo:
hugo new 1963/11/22/page_1.md  # Front page
hugo new 1963/11/22/articles/kennedy-obituary.md  # Article
hugo new 1963/11/22/stocks/market-report.md  # Stock data


Edit the file, fill in front matter, and add transcription.

Test locally:
hugo server

Check http://localhost:1313/1963/11/22/page_1.

Submit a pull request:
git add .
git commit -m "Add transcription for 1963-11-22 front page"
git push origin main

Fork the repo if you’re not a collaborator and create a PR on GitHub.


Deployment
The site runs on a Debian 13 VPS with Nginx, hosted by Cloudzy. A cron job pulls updates every 30 minutes and rebuilds the site. Once your PR is merged, changes go live automatically.
License
All content is in the public domain. By submitting, you waive ownership but can take credit in the transcriber field or your data/transcribers/your-name.json file.
Contact
Open an issue on GitHub or email derek@derekstevens.net for questions.

Preserving history, one page at a time.
