### Step 1: Create the main user: 'derek'
Logged in as root:
```
useradd -m derek
passwd derek  # Set a strong password
```
This creates a home directory /home/derek.

### Step 2: Create the main user: 'derek'
To allow 'derek' to use sudo (needed for some system commands later):
```
visudo
```
Add this line at the end: `derek ALL=(ALL:ALL) ALL`. Save and exit (CTRL-W, CTRL-O).

### Step 3: Install Git and GitHub CLI (gh)
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

### Step 4: Log In to GitHub via gh CLI
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

### Step 5: Then clone repository
```
gh repo clone derekstevens.net /home/derek/derekstevens.net
```
