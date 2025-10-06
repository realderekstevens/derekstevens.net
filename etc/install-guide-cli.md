### Step 1: Create the main user: 'derek'
Logged in as root:
```
useradd -m derek
passwd derek  # Set a strong password
```
This creates a home directory /home/derek.

To allow 'derek' to use sudo (needed for some system commands later):
```
visudo
```
Add this line at the end: `derek ALL=(ALL:ALL) ALL`. Save and exit.
```
