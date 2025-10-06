#!/bin/bash

# bubblegum.sh: Automation script for derekstevens.net setup and updates
# Run as root for setup, as derek for content/update commands
# Usage: ./bubblegum.sh [setup|update|new-front-page|new-article|new-stock|help]

# Hardcoded values (move to .env later)
VPS_USER="derek"
SITE_DIR="/var/www/derekstevens.net"
REPO_URL="https://github.com/realderekstevens/derekstevens.net.git"
NGINX_CONF="/etc/nginx/sites-available/derekstevens.net"

# Ensure script is executable: chmod +x bubblegum.sh

case "$1" in
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
    cd /tmp
    wget https://github.com/gohugoio/hugo/releases/download/v0.151.0/hugo_extended_0.151.0_linux-amd64.deb
    dpkg -i hugo_extended_0.151.0_linux-amd64.deb || apt --fix-broken install -y
    hugo version

    # Step 3: Create user 'derek'
    echo "Creating user derek..."
    useradd -m -s /bin/bash "$VPS_USER"
    passwd "$VPS_USER"
    usermod -aG www-data "$VPS_USER"
    echo "$VPS_USER ALL=(ALL:ALL) ALL" > /etc/sudoers.d/"$VPS_USER"
    chmod 0440 /etc/sudoers.d/"$VPS_USER"

    # Step 4: Set up site directory
    echo "Setting up site directory..."
    mkdir -p "$SITE_DIR"
    chown -R "$VPS_USER:$VPS_USER" "$SITE_DIR"

    # Step 5: Initialize Hugo site (if not cloning existing repo)
    echo "Initializing Hugo site..."
    su - "$VPS_USER" -c "cd $SITE_DIR && hugo new site . --force && git init"

    # Step 6: Install Hugo Book theme
    echo "Installing Hugo Book theme..."
    su - "$VPS_USER" -c "cd $SITE_DIR && git submodule add https://github.com/alex-shpak/hugo-book themes/hugo-book"
    su - "$VPS_USER" -c "echo 'theme = \"hugo-book\"' >> $SITE_DIR/hugo.toml"

    # Step 7: Configure hugo.toml
    echo "Configuring hugo.toml..."
    su - "$VPS_USER" -c "cat > $SITE_DIR/hugo.toml << EOL
baseURL = \"https://derekstevens.net/\"
languageCode = \"en-us\"
title = \"Derek Stevens Net - Newspaper Transcriptions\"
theme = \"hugo-book\"

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

    # Step 8: Install GitHub CLI
    echo "Installing GitHub CLI..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    apt update
    apt install -y gh

    # Step 9: Clone or initialize GitHub repo
    echo "Setting up GitHub repository..."
    su - "$VPS_USER" -c "cd $SITE_DIR && git clone $REPO_URL . || { git remote add origin $REPO_URL && git add . && git commit -m 'Initial Hugo site setup' && git push -u origin main; }"
    su - "$VPS_USER" -c "cd $SITE_DIR && git submodule update --init --recursive"

    # Step 10: Configure Nginx
    echo "Configuring Nginx..."
    cat > "$NGINX_CONF" << EOL
server {
    listen 80;
    listen [::]:80;
    server_name derekstevens.net www.derekstevens.net;

    root $SITE_DIR/public;
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
    }
}
EOL
    ln -s "$NGINX_CONF" /etc/nginx/sites-enabled/
    nginx -t && systemctl reload nginx

    # Step 11: Set up SSL with Certbot
    echo "Setting up SSL..."
    certbot --nginx -d derekstevens.net -d www.derekstevens.net

    # Step 12: Configure Postfix and Dovecot
    echo "Setting up email..."
    dpkg-reconfigure postfix  # Choose 'Internet Site', set 'mail.derekstevens.net'
    cat > /etc/postfix/main.cf << EOL
myhostname = mail.derekstevens.net
mydestination = derekstevens.net, mail.derekstevens.net, localhost
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
inet_interfaces = all
EOL
    sed -i 's/^mail_location.*/mail_location = maildir:~/Maildir/' /etc/dovecot/conf.d/10-mail.conf
    sed -i 's/^ssl.*/ssl = required/' /etc/dovecot/conf.d/10-ssl.conf
    su - "$VPS_USER" -c "mkdir ~/Maildir"
    systemctl restart postfix dovecot

    # Step 13: Set up cron for auto-updates
    echo "Setting up cron job..."
    su - "$VPS_USER" -c "crontab -l > /tmp/crontab.tmp; echo '*/30 * * * * cd $SITE_DIR && git pull origin main && hugo --destination $SITE_DIR/public && chown -R $VPS_USER:$VPS_USER $SITE_DIR/public' >> /tmp/crontab.tmp; crontab /tmp/crontab.tmp; rm /tmp/crontab.tmp"

    # Step 14: Enable firewall
    echo "Enabling firewall..."
    ufw enable

    echo "Setup complete! Run './bubblegum.sh update' as derek to build and deploy."
    ;;

  update)
    # Update site: Pull from GitHub, build, and fix permissions
    if [ "$(whoami)" != "$VPS_USER" ]; then
      echo "Run 'update' as $VPS_USER, not $(whoami)."
      exit 1
    fi
    echo "Updating site..."
    cd "$SITE_DIR"
    git pull origin main
    hugo --destination "$SITE_DIR/public"
    chown -R "$VPS_USER:$VPS_USER" "$SITE_DIR/public"
    echo "Site updated at https://derekstevens.net"
    ;;

  new-front-page)
    # Create a new newspaper front page
    if [ "$(whoami)" != "$VPS_USER" ]; then
      echo "Run 'new-front-page' as $VPS_USER, not $(whoami)."
      exit 1
    fi
    if [ -z "$2" ]; then
      echo "Usage: ./bubblegum.sh new-front-page YYYY/MM/DD"
      exit 1
    fi
    echo "Creating new front page for $2..."
    cd "$SITE_DIR"
    hugo new "$2/page_1.md"
    echo "Created $SITE_DIR/content/$2/page_1.md"
    ;;

  new-article)
    # Create a new article
    if [ "$(whoami)" != "$VPS_USER" ]; then
      echo "Run 'new-article' as $VPS_USER, not $(whoami)."
      exit 1
    fi
    if [ -z "$2" ] || [ -z "$3" ]; then
      echo "Usage: ./bubblegum.sh new-article YYYY/MM/DD article-name"
      exit 1
    fi
    echo "Creating new article $3 for $2..."
    cd "$SITE_DIR"
    hugo new "$2/articles/$3.md"
    echo "Created $SITE_DIR/content/$2/articles/$3.md"
    ;;

  new-stock)
    # Create a new stock numbers page
    if [ "$(whoami)" != "$VPS_USER" ]; then
      echo "Run 'new-stock' as $VPS_USER, not $(whoami)."
      exit 1
    fi
    if [ -z "$2" ] || [ -z "$3" ]; then
      echo "Usage: ./bubblegum.sh new-stock YYYY/MM/DD stock-report-name"
      exit 1
    fi
    echo "Creating new stock page $3 for $2..."
    cd "$SITE_DIR"
    hugo new "$2/stocks/$3.md"
    echo "Created $SITE_DIR/content/$2/stocks/$3.md"
    ;;

  help|*)
    echo "Usage: ./bubblegum.sh [command]"
    echo "Commands:"
    echo "  setup           - Run as root: Set up Debian 13 VPS with Hugo, Nginx, email, and cron"
    echo "  update          - Run as derek: Pull Git changes, build site, and fix permissions"
    echo "  new-front-page  - Run as derek: Create a new front page (e.g., ./bubblegum.sh new-front-page 1963/11/22)"
    echo "  new-article     - Run as derek: Create a new article (e.g., ./bubblegum.sh new-article 1963/11/22 kennedy-obituary)"
    echo "  new-stock       - Run as derek: Create a new stock page (e.g., ./bubblegum.sh new-stock 1963/11/22 market-report)"
    echo "  help            - Show this help message"
    ;;
esac
