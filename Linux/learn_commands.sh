#!/bin/bash
# dummy script to store Linux commands learnt in Udemy course

echo "Hi, below are scipts I learnt"


pwd #Displays the present working directory
/home/yourusername

# cd - Changes the current directory to home directory
cd ~

ls - #Lists directory contents (using dir for WSL; replace with ls if installed)
/home/yourusername/scripts  # Note: WSL uses 'dir' by default; install coreutils for 'ls'

echo #Displays arguments to the screen
Hello, this is a test message!

man # Displays manual pages (example with 'ls'; run manually to avoid pause)
man ls  # Uncomment to test, press 'q' to quit

# exit - Exits the shell (commented out to avoid closing session)
exit

# clear - Clears the screen (commented out to keep output visible)
clear

# man -k - Searches man pages for a term (example with 'list')
man -k list | head -n 5  # Limits to first 5 results

# Examining $PATH - Shows the environment variable for command search paths
$PATH

# List files in the first directory of $PATH
FIRST_PATH=$(echo "$PATH" | cut -d':' -f1)
/home/yourusername/scripts "$FIRST_PATH"  # Replace 'ls' with 'dir' if ls isn’t available

# --help - Asking commands for help (example with 'cat')
cat --help


cd ~ # Changes the current directory to home directory
output: (No output, changes directory silently)

dir # Lists directory contents (using dir for WSL; replace with ls if installed)
output: (Lists files in current directory, e.g., dir1 file1 file2)

cat "$0" # Concatenates and displays this script’s contents
output: (Shows the full script text)

which bash # Locates the full path of the bash command
output: /bin/bash

# --- Useful ls Options ---
dir -a # Lists all files, including hidden ones (starts with .)
output: (Lists all files, e.g., .hidden dir1 file1)

dir --color # Lists files with colorized output (if supported)
output: (Lists files with color, e.g., dir1 in blue, file1 in white)

dir -d # Lists directory names, not their contents
output: (Shows only ., e.g., current directory name)

dir -l # Uses long listing format (permissions, owner, size, etc.)
output: (e.g., -rw-r--r-- 1 user user 123 Apr 1 12:00 file1)

dir -r # Reverses the order of the listing
output: (e.g., file2 file1 dir1)

dir -R # Lists files recursively (includes subdirectories)
output: (e.g., .: file1 dir1  ./dir1: subfile)

dir -t # Sorts by modification time, most recent first
output: (e.g., newestfile file1 dir1)

# --- Symbolic Links ---
ln -s "$0" ~/mylink # Creates a symbolic link to this script
output: (No output, creates ~/mylink)

dir -l # Shows symbolic links (check the link we made)
output: (e.g., lrwxrwxrwx 1 user user 123 Apr 1 12:00 mylink -> /home/yourusername/scripts/learn_commands.sh)

# --- Permissions ---
touch ~/testfile # Creates a test file for permission demos
output: (No output, creates ~/testfile)

chmod 644 ~/testfile # Sets numeric permissions (rw-r--r--)
output: (No output, changes permissions)

dir -l ~/testfile # Verifies permissions on testfile
output: (e.g., -rw-r--r-- 1 user user 0 Apr 1 12:00 testfile)

chmod u+x ~/testfile # Adds execute permission for user
output: (No output, changes permissions)

dir -l ~/testfile # Verifies updated permissions
output: (e.g., -rwxr--r-- 1 user user 0 Apr 1 12:00 testfile)

chmod g-w ~/testfile # Removes write permission for group
output: (No output, changes permissions)

dir -l ~/testfile # Verifies updated permissions
output: (e.g., -rwxr-xr-- 1 user user 0 Apr 1 12:00 testfile)

# --- Working with Groups ---
chown :$USER ~/testfile # Changes group ownership to current user’s group
output: (No output, changes group)

dir -l ~/testfile # Verifies group ownership
output: (e.g., -rwxr-xr-- 1 user user 0 Apr 1 12:00 testfile)

# --- File Creation Mask ---
umask # Displays the current file creation mask
output: (e.g., 022)

umask 002 # Sets mask to allow group write (new files get 664)
output: (No output, sets mask)

touch ~/newfile # Creates a file with the new mask
output: (No output, creates ~/newfile)

dir -l ~/newfile # Verifies permissions with new mask
output: (e.g., -rw-rw-r-- 1 user user 0 Apr 1 12:00 newfile)