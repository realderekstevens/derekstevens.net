Derek Stevens Net
Welcome to Derek Stevens Net, a community-driven project to transcribe and preserve historical newspaper front pages and articles. This site, hosted at derekstevens.net, focuses on archiving newspaper content from significant historical dates, such as the Kennedy assassination on November 22, 1963. Built with Hugo and the Book theme, it offers a clean, searchable interface for researchers, historians, and enthusiasts.
The site is structured by date (e.g., derekstevens.net/YYYY/MM/DD/page_1), with front pages, articles, and stock market data from newspapers. Contributions are welcome via GitHub to expand our archive.
Project Goals

Transcribe historical newspaper front pages and articles in Markdown.
Provide structured data for stock market reports from financial sections.
Enable community contributions through GitHub pull requests.
Maintain a fast, static site hosted on a Debian 13 VPS with Nginx.
Link to a separate insurance services site for business inquiries.

Tech Stack

Hugo: Static site generator for fast, lightweight pages.
Hugo Book Theme: Clean, documentation-style theme for readability.
Nginx: Serves static files on a Cloudzy Debian 13 VPS.
GitHub: Hosts the repository and manages contributions.
JSON Data: Stores structured data for stocks and metadata.
Cron Jobs: Automate content updates by pulling Git changes.

Getting Started
To explore the site locally or contribute, follow these steps.
Prerequisites

Hugo (Extended version recommended)
Git
A text editor (e.g., VS Code, Neovim)

Installation

Clone the Repository:
git clone https://github.com/realderekstevens/derekstevens.net.git
cd derekstevens.net


Install Submodules (for the Book theme):
git submodule update --init --recursive


Install Hugo (if not already installed):

On Debian/Ubuntu:sudo apt update
sudo apt install hugo


Or download from gohugo.io.


Run Locally:
hugo server

Visit http://localhost:1313 to preview the site.


Contributing
We welcome contributions to transcribe newspaper front pages, articles, or stock data. Follow these steps to add content.
Content Structure

Front Pages: Stored as content/YYYY/MM/DD/page_1.md (e.g., content/1963/11/22/page_1.md).
Articles: Stored as content/YYYY/MM/DD/articles/article-name.md.
Stock Data: Stored as content/YYYY/MM/DD/stocks/market-report.md or in data/YYYY/MM/DD/stocks.json.
URL Format: Content at content/1963/11/22/page_1.md appears at derekstevens.net/1963/11/22/page_1.

Adding Content

Create a New File:Use Hugo to generate content with archetypes:
hugo new 1963/11/22/page_1.md  # For a front page
hugo new 1963/11/22/articles/kennedy-obituary.md  # For an article
hugo new 1963/11/22/stocks/market-report.md  # For stock data

This uses predefined archetypes (archetypes/newspaper-front-page.md, archetypes/articles.md, archetypes/stock-numbers.md) to set metadata.

Edit the File:

Open the generated Markdown file in a text editor.
Fill in front matter (e.g., pub_date, newspaper, transcriber) and add transcribed content.
Example front page for November 22, 1963:+++
date = "2025-10-06T14:00:00Z"
draft = false
title = "Front Page - November 22, 1963"
weight = 1
tags = ["newspaper", "front-page", "historical", "kennedy", "assassination"]
categories = ["Newspaper Front Pages"]
pub_date = "1963-11-22"
newspaper = "The Dallas Morning News"
edition = "Late Edition"
headlines = ["President Kennedy Shot Dead in Dallas Motorcade", "Governor Connally Wounded in Attack"]
source_url = "https://example.com/dallas-morning-news-1963-11-22"
transcriber = "Your Name"
transcription_status = "partial"
+++
## Front Page - The Dallas Morning News (1963-11-22)
*Late Edition*
### Major Headlines
{{ range .Params.headlines }}
- {{ . }}
{{ end }}
### Front Page Summary
President Kennedy was assassinated in Dallas...




Test Locally:
hugo server

Check the new page at http://localhost:1313/YYYY/MM/DD/page_1.

Commit and Push:
git add .
git commit -m "Add transcription for 1963-11-22 front page"
git push origin main


Submit a Pull Request:

Fork the repository if you’re not a collaborator.
Create a pull request (PR) on GitHub with a clear description of your changes (e.g., “Added transcription for Dallas Morning News, 1963-11-22”).
Include any notes on transcription challenges or sources.



Contribution Guidelines

Accuracy: Verify transcriptions against original scans (e.g., from newspapers.com or library archives).
Format: Use Markdown for text and JSON for structured data (e.g., stock prices).
Metadata: Fill in all front matter fields, especially pub_date, newspaper, and transcription_status.
Sources: Provide a source_url to the original scan or archive when possible.
Images: If including images, place them in static/images/YYYY/MM/DD/ and reference with {{< figure src="/images/YYYY/MM/DD/image.jpg" >}}.

Example Contribution
To transcribe a new front page:

Run hugo new 1941/12/07/page_1.md.
Edit content/1941/12/07/page_1.md with headlines and summary from the Pearl Harbor attack coverage.
Commit and submit a PR.

Deployment
The site is automatically updated via a cron job on the Debian 13 VPS, pulling changes from this repository. After your PR is merged:

The cron job runs git pull and hugo to rebuild the site.
Static files are served from /var/www/derekstevens.net via Nginx.

To deploy manually:
hugo  # Build static files to /public/
rsync -avz public/ derek@your-vps-ip:/var/www/derekstevens.net/

Additional Notes

Data Storage: Stock data can be stored in data/YYYY/MM/DD/stocks.json for easy parsing in Hugo templates.
Cron Jobs: The VPS pulls updates every 30 minutes (*/30 * * * * cd ~/sites/derekstevens.net && git pull origin main && hugo --destination /var/www/derekstevens.net).
Insurance Link: A footer link to an external insurance site is included for business inquiries.
Contact: For questions, open an issue on GitHub or email info@derekstevens.net.

License
This project is licensed under the MIT License. See the LICENSE file for details.

Built with ❤️ by Derek Stevens and the community.




### Step-by-Step Setup Guide for Hugo Site with Hugo-Book Theme on Debian 13

This guide assumes you have just provisioned a fresh Debian 13 VPS on Cloudzy and are logged in as the root user via SSH. 

We'll proceed sequentially, starting with system basics, user creation, installations, GitHub integration, Hugo setup, web server configuration, email server setup, and SSL. 

All commands are to be run as root unless specified otherwise. 

We'll use nano for editing files. 

The site will be hosted at <derekstevens.net> and <www.derekstevens.net>;
with email at <mail.derekstevens.net> & <www.mail.derekstevens.net>. 

The Hugo site will use the hugo-book theme for documentation-style content.

We'll create a non-root user derek for security, and all site/email files will be owned by derek:derek (not $USER:$USER). Ownership commands will explicitly use derek:derek.

### Step 0: update
Logged in as root:
```
sudo apt update && apt upgrade -y
sudo apt install -y git wget curl ufw nginx rsync python3-certbot-nginx
```
This upates the Debian 13 OS to the must recent version and installs the needed git commands.

### Step 1: setup / disable firewall 
updateThen setup the firewall (UFW) to abide by the port for nginx, disable it for now
```
ufw allow 'Nginx Full'
ufw allow OpenSSH
ufw disable
```

### Step 2: Install Hugo_Extended Library directly from Github
Logged in as root:
```
cd /tmp
wget https://github.com/gohugoio/hugo/releases/download/v0.151.0/hugo_extended_0.151.0_linux-amd64.deb
sudo dpkg -i hugo_extended_0.151.0_linux-amd64.deb
hugo version
```
This installs the most recent version of Hugo Extended directly to the Debian 13 libraries.

### Step 3: Create the User 'derek'
Logged in as root:
```
useradd -m derek
passwd derek  # Set a strong password
```
This creates a home directory /home/derek.

Add 'derek' to the www-data group (for Nginx compatibility; first install Nginx if group doesn't exist yet, but we'll add later):
```
groupadd www-data  # If it doesn't exist
usermod -aG www-data derek
```
To allow 'derek' to use sudo (needed for some system commands later):
```
visudo
```
Add this line at the end: `derek ALL=(ALL:ALL) ALL`. Save and exit.

```
CTRL+W  #then hit 'y'
CTRL+O
```

### Step 4: Change ownership of file to 'Derek' to abide by him being the one serving it out 
```
sudo mkdir -p /var/www/derekstevens.net
sudo chown derek:derek /var/www/derekstevens.net  # Own it
cd /var/www/derekstevens.net
```
### Optional Step: If you are making a brand new hugo website; Use below command. Skip if using pre-existing github entry.
```
hugo new site . --force  # Dot for current dir
git init
```


### Step 5: Install Git and GitHub CLI (gh)
As derek:
```
sudo apt install -y gh
```
Install gh (GitHub CLI) via the official method:
```
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh
```
### Step 6: Log In to GitHub via gh CLI
As derek, authenticate gh with your GitHub account (this enables SSH-like access for repos and embedded links in Hugo):
```
gh auth login
```

Choose "GitHub.com".
Select "HTTPS" as the protocol (or "SSH" if you prefer; ensure your SSH key is added to GitHub via gh ssh-key add ~/.ssh/id_ed25519.pub first).
Authenticate via browser (it will open a URL; log in on GitHub and authorize).
Choose "Login with token" if prompted, and follow the steps.

Verify:
```
gh auth status
```
This sets up GitHub integration, so Hugo's "Edit this page" or commit links (if configured) will work via SSH/HTTPS.

### Step 7: Then setup certbot
```
apt install certbot python3-certbot-nginx -y
certbot --nginx -d derekstevens.net www.derekstevens.net
```
