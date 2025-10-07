#!/bin/bash

# cli.sh: Automation script for derekstevens.net setup and updates
# Run as root for setup, gh-auth, and hugo; as derek for content/update commands
# Usage: ./cli.sh [setup|gh-auth|hugo|update|new-front-page|new-article|new-stock|help]

# Hardcoded values (move to .env later)
VPS_USER="derek"
SITE_DIR="/home/derek/derekstevens.net"
REPO_URL="https://github.com/realderekstevens/derekstevens.net.git"
NGINX_CONF="/etc/nginx/sites-available/derekstevens.net"
WEB_DIR="/var/www/derekstevens.net"

# Ensure script is executable: chmod +x cli.sh

case "$1" in
  gh-auth)
    # Install and configure GitHub CLI
    echo "Installing GitHub CLI for user $VPS_USER..."
    apt update
    apt install -y git gh
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    apt update
    apt install -y gh
    echo "Run 'gh auth login' as $VPS_USER to authenticate with GitHub."
    echo "Example: su - $VPS_USER; gh auth login"
    ;;

  setup)
    # Step 0: Update system and install basics
    echo "Updating system and installing packages..."
    apt update && apt upgrade -y
    apt install -y git wget curl ufw nginx rsync python3-certbot-nginx postfix dovecot-core dovecot-imapd dovecot-pop3d

    # Step 1: Configure firewall (disabled initially)
    echo "Setting up firewall..."
    ufw allow OpenSSH
    ufw allow 'Nginx Full'
    ufw allow 25  # SMTP
    ufw allow 143 # IMAP
    ufw allow 110 # POP3
    ufw disable

    # Step 2: Install Hugo Extended
    echo "Installing Hugo Extended..."
    cd /tmp || exit 1
    wget https://github.com/gohugoio/hugo/releases/download/v0.151.0/hugo_extended_0.151.0_linux-amd64.deb
    dpkg -i hugo_extended_0.151.0_linux-amd64.deb || apt --fix-broken install -y
    hugo version

    # Step 3: Create user 'derek' (skip if exists)
    if ! id "$VPS_USER" &>/dev/null; then
      echo "Creating user $VPS_USER..."
      useradd -m -s /bin/bash "$VPS_USER"
      passwd "$VPS_USER"
      usermod -aG www-data "$VPS_USER"
      echo "$VPS_USER ALL=(ALL:ALL) ALL" > /etc/sudoers.d/"$VPS_USER"
      chmod 0440 /etc/sudoers.d/"$VPS_USER"
    else
      echo "User $VPS_USER already exists, skipping creation."
    fi

    # Step 4: Set up site directory
    echo "Setting up site directory..."
    mkdir -p "$SITE_DIR"
    chown -R "$VPS_USER:$VPS_USER" "$SITE_DIR"

    # Step 5: Initialize Hugo site (if not cloning existing repo)
    echo "Initializing Hugo site..."
    su - "$VPS_USER" -c "cd $SITE_DIR && { [ -d .git ] || { hugo new site . --force && git init; } }"

    # Step 6: Install Hugo Book theme
    echo "Installing Hugo Book theme..."
    su - "$VPS_USER" -c "cd $SITE_DIR && { [ -d themes/hugo-book ] || git submodule add https://github.com/alex-shpak/hugo-book themes/hugo-book; }"
    su - "$VPS_USER" -c "echo 'theme = \"hugo-book\"' >> $SITE_DIR/hugo.toml"

    # Step 7: Configure hugo.toml
    echo "Configuring hugo.toml..."
    su - "$VPS_USER" -c "cat > $SITE_DIR/hugo.toml << EOL
baseURL = \"https://derekstevens.net/\"
languageCode = \"en-us\"
title = \"Derek Stevens Net - Newspaper Transcriptions\"
theme = \"hugo-book\"
defaultContentLanguage = \"en\"
defaultContentLanguageInSubdir = false

[languages]
  [languages.en]
    title = \"Derek Stevens Net\"
    languageName = \"English\"
    contentDir = \"content.en\"
    weight = 1

[permalinks]
  \"\" = \"/:year/:month/:day/:slug\"

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true

[params]
  BookTheme = \"light\"
  BookToC = true
  BookSection = \"*\"
  BookRepo = \"https://github.com/realderekstevens/derekstevens.net\"
  BookEditPath = \"edit/main/content\"

enableGitInfo = true
EOL"

    # Step 8: Clone or initialize GitHub repo
    echo "Setting up GitHub repository..."
    su - "$VPS_USER" -c "cd $SITE_DIR && { [ -d .git ] && git remote get-url origin | grep -q \"$REPO_URL\" || { git clone $REPO_URL . || { git remote add origin $REPO_URL && git add . && git commit -m 'Initial Hugo site setup' && git push -u origin main; }; } }"
    su - "$VPS_USER" -c "cd $SITE_DIR && git submodule update --init --recursive"

    # Step 9: Configure Nginx
    echo "Configuring Nginx..."
    mkdir -p "$WEB_DIR"
    chown -R www-data:www-data "$WEB_DIR"
    cat > "$NGINX_CONF" << EOL
server {
    listen 80;
    listen [::]:80;
    server_name derekstevens.net www.derekstevens.net;

    root $WEB_DIR;
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
    }
}
EOL
    ln -sf "$NGINX_CONF" /etc/nginx/sites-enabled/
    nginx -t && systemctl reload nginx

    # Step 10: Set up SSL with Certbot
    echo "Setting up SSL..."
    certbot --nginx -d derekstevens.net -d www.derekstevens.net

    # Step 11: Configure Postfix and Dovecot
    echo "Setting up email..."
    dpkg-reconfigure postfix --default  # Non-interactive, assumes 'Internet Site'
    cat > /etc/postfix/main.cf << EOL
myhostname = mail.derekstevens.net
mydestination = derekstevens.net, mail.derekstevens.net, localhost
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
inet_interfaces = all
EOL
    sed -i 's/^mail_location.*/mail_location = maildir:~/Maildir/' /etc/dovecot/conf.d/10-mail.conf
    sed -i 's/^ssl.*/ssl = required/' /etc/dovecot/conf.d/10-ssl.conf
    su - "$VPS_USER" -c "mkdir -p ~/Maildir"
    systemctl restart postfix dovecot

    # Step 12: Set up cron for auto-updates
    echo "Setting up cron job..."
    su - "$VPS_USER" -c "crontab -l > /tmp/crontab.tmp 2>/dev/null; echo '*/30 * * * * cd $SITE_DIR && git pull origin main && hugo --destination $SITE_DIR/public && rsync -av --delete $SITE_DIR/public/ $WEB_DIR/' >> /tmp/crontab.tmp; crontab /tmp/crontab.tmp; rm /tmp/crontab.tmp"

    # Step 13: Enable firewall
    echo "Enabling firewall..."
    ufw enable

    echo "Setup complete! Run './cli.sh gh-auth' as root, then 'gh auth login' as $VPS_USER to authenticate GitHub."
    echo "Then use './cli.sh update' or './cli.sh hugo' as $VPS_USER/root to build and deploy."
    ;;

  hugo)
    # Build Hugo site and sync to web directory
    if [ "$(whoami)" != "root" ] && [ "$(whoami)" != "$VPS_USER" ]; then
      echo "Run 'hugo' as root or $VPS_USER, not $(whoami)."
      exit 1
    fi
    echo "Building Hugo site and deploying to $WEB_DIR..."
    cd "$SITE_DIR" || exit 1
    rm -rf "$SITE_DIR/public"/* "$WEB_DIR"/*
    hugo --destination "$SITE_DIR/public"
    rsync -av --delete "$SITE_DIR/public/" "$WEB_DIR/"
    chown -R www-data:www-data "$WEB_DIR"
    echo "Site deployed to $WEB_DIR, accessible at https://derekstevens.net"
    ;;

  update)
    if [ "$(whoami)" != "$VPS_USER" ]; then
      echo "Run 'update' as $VPS_USER, not $(whoami)."
      exit 1
    fi
    echo "Updating site..."
    cd "$SITE_DIR" || exit 1
    git pull origin main
    hugo --destination "$SITE_DIR/public"
    rsync -av --delete "$SITE_DIR/public/" "$WEB_DIR/"
    chown -R www-data:www-data "$WEB_DIR"
    echo "Site updated at https://derekstevens.net"
    ;;

  new-front-page)
    if [ "$(whoami)" != "$VPS_USER" ]; then
      echo "Run 'new-front-page' as $VPS_USER, not $(whoami)."
      exit 1
    fi
    if [ -z "$2" ]; then
      echo "Usage: ./cli.sh new-front-page YYYY/MM/DD"
      exit 1
    fi
    echo "Creating new front page for $2..."
    cd "$SITE_DIR" || exit 1
    hugo new --kind newspaper-front-page "en/$2/page_1.md"
    echo "Created $SITE_DIR/content.en/$2/page_1.md"
    ;;

  new-article)
    if [ "$(whoami)" != "$VPS_USER" ]; then
      echo "Run 'new-article' as $VPS_USER, not $(whoami)."
      exit 1
    fi
    if [ -z "$2" ] || [ -z "$3" ]; then
      echo "Usage: ./cli.sh new-article YYYY/MM/DD article-name"
      exit 1
    fi
    echo "Creating new article $3 for $2..."
    cd "$SITE_DIR" || exit 1
    hugo new --kind articles "en/$2/articles/$3.md"
    echo "Created $SITE_DIR/content.en/$2/articles/$3.md"
    ;;

  new-stock)
    if [ "$(whoami)" != "$VPS_USER" ]; then
      echo "Run 'new-stock' as $VPS_USER, not $(whoami)."
      exit 1
    fi
    if [ -z "$2" ] || [ -z "$3" ]; then
      echo "Usage: ./cli.sh new-stock YYYY/MM/DD stock-report-name"
      exit 1
    fi
    echo "Creating new stock page $3 for $2..."
    cd "$SITE_DIR" || exit 1
    hugo new --kind stock-numbers "en/$2/stocks/$3.md"
    echo "Created $SITE_DIR/content.en/$2/stocks/$3.md"
    ;;

  help|*)
    echo "Usage: ./cli.sh [command]"
    echo "Commands:"
    echo "  setup           - Run as root: Set up Debian 13 VPS with Hugo, Nginx, email, and cron"
    echo "  gh-auth         - Run as root: Install GitHub CLI and configure user"
    echo "  hugo            - Run as root or derek: Build site and sync to web server"
    echo "  update          - Run as derek: Pull Git changes, build site, and sync to web server"
    echo "  new-front-page  - Run as derek: Create a new front page (e.g., ./cli.sh new-front-page 1963/11/22)"
    echo "  new-article     - Run as derek: Create a new article (e.g., ./cli.sh new-article 1963/11/22 kennedy-obituary)"
    echo "  new-stock       - Run as derek: Create a new stock page (e.g., ./cli.sh new-stock 1963/11/22 market-report)"
    echo "  help            - Show this help message"
    ;;
esac
