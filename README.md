https://derekstevens.net
This is a simple website for transcribing historical newspapers, focusing on front pages, articles, and stock market data from key dates (like November 22, 1963, when Kennedy was shot). No ads, no trackers, just pure history. Built with Hugo and the Book theme for a clean, searchable archive.
Submit transcriptions to get credit. Join us to preserve the past!
Ways to Contribute

Transcribe a newspaper front page, article, or stock data.
Add a high-quality image of a newspaper scan (if you have legal access to it).
Fix errors in transcriptions or improve existing content.

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
Open an issue on GitHub or email info@derekstevens.net for questions.

Preserving history, one page at a time.
--



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
