### Step-by-Step Website/Email Server Setup Guide for Hugo Site with Hugo-Book Theme on Debian 13

This guide walks you through setting up a Hugo website with the Hugo Book theme on a fresh Debian 13 (Trixie) VPS hosted by Cloudzy, serving content at derekstevens.net and www.derekstevens.net, with email at mail.derekstevens.net and www.mail.derekstevens.net. The site is designed for transcribing historical newspapers, with content structured as derekstevens.net/YYYY/MM/DD/page_1. It uses Nginx, Postfix/Dovecot for email, and GitHub for content management.

This guide is how I setup my server; It assumes you have just provisioned a fresh Debian 13 VPS on Cloudzy and are logged in as the root user via SSH. 

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

### Step 6.5: Then clone repository
```
gh repo clone derekstevens.net /home/derek/derekstevens.net
```

### Step 6.6: Change ownership of file to 'Derek' to abide by him being the one serving it out 
```
sudo chown derek:derek /var/www/derekstevens.net
sudo chown derek:derek /home/derek/derekstevens.net
cd /home/derek/derekstevens.net
```

### Step 6.7: Delete Default; Copy/Paste ngnix website files; Link it up
```
rm /etc/nginx/sites-available/default
cp /home/derek/derekstevens.net/etc/nginx/sites-available/derekstevens.net /etc/nginx/sites-available/
cp /home/derek/derekstevens.net/etc/nginx/sites-available/mail.derekstevens.net /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/derekstevens.net /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/mail.derekstevens.net /etc/nginx/sites-enabled/
cd /home/derek/derekstevens.net
```

### Step 7: Then setup certbot
```
apt install certbot python3-certbot-nginx -y
certbot --nginx -d derekstevens.net www.derekstevens.net mail.derekstevens.net www.mail.derekstevens.net
```







