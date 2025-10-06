### Step 1: Create the main user: 'derek'
Logged in as root:
```
useradd -m derek
passwd derek  # Set a strong password
```
This also creates a home directory /home/derek.

### Step 2: Add more privileges to main user 'derek':
```
visudo
```
Add this line at the end under "User privilege specification" (under the root): `derek ALL=(ALL:ALL) ALL`. Save and exit (CTRL-W, CTRL-O).

### Step 3: Change into the main user (derek):
```
su - derek
```

### Step 4: Install gh (GitHub CLI) via the official method:
```
sudo apt install -y gh git
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
```

### Step 5: Log In to GitHub via gh CLI
As main user (derek), authenticate gh with your GitHub account (this enables SSH-like access for repos and embedded links in Hugo):
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

### Step 6: Then clone repository
```
gh repo clone derekstevens.net /home/derek/derekstevens.net
```

### Step 7: Change into the directory (as main user) then give the file modification privlidges for the system
```
cd /home/derek/derekstevens.net
chmod +x cli.sh
```

### Step 7: Use the CLI to automate the install process, follow the help guide:
```
./cli.sh setup
```
