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

# --- Finding Files and Directories ---
find . # Recursively finds all files in the current directory
output: (e.g., . ./file1 ./dir1 ./dir1/subfile)

find . -name "*.sh" # Finds files matching pattern (*.sh)
output: (e.g., ./learn_commands.sh)

find . -iname "TEST*" # Finds files matching pattern, case-insensitive
output: (e.g., ./testfile ./TestFile)

find . -ls # Performs ls (dir in WSL) on found items
output: (e.g., -rw-r--r-- 1 user user 123 Apr 1 file1)

find . -mtime 1 # Finds files modified 1 day ago
output: (e.g., ./yesterday_file)

find . -size +10k # Finds files larger than 10 kilobytes
output: (e.g., ./bigfile)

find . -newer ~/testfile # Finds files newer than testfile
output: (e.g., ./newfile)

find . -exec dir {} \; # Runs dir on all found files
output: (e.g., file1  file2  dir1)

locate bash # Lists files matching pattern (faster, uses index)
output: (e.g., /bin/bash /etc/bash.bashrc)

# --- Viewing and Editing Files ---
cat ~/testfile # Displays the contents of testfile
output: (Contents of testfile, or blank if empty)

more ~/testfile # Browses through a text file (press q to quit)
output: (Shows testfile contents, paginated)

less ~/testfile # Browses with more features than more (press q to quit)
output: (Shows testfile contents, scrollable)

head ~/testfile # Outputs the top 10 lines of testfile
output: (First 10 lines, or less if shorter)

tail ~/testfile # Outputs the bottom 10 lines of testfile
output: (Last 10 lines, or less if shorter)

tail -n 15 ~/testfile # Outputs the last 15 lines of testfile
output: (Last 15 lines, or less if shorter)

tail -f ~/testfile # Follows testfile, showing new data as written
output: (Waits and displays new lines; Ctrl+C to stop)

# nano ~/testfile # Opens nano editor (commented out; run manually)
# output: (Opens editor; Ctrl+O to save, Ctrl+X to exit)

# --- Deleting, Copying, Moving, and Renaming Files ---
rm ~/newfile # Removes the file newfile
output: (No output, deletes ~/newfile)

rm -r ~/testdir # Removes directory testdir and its contents recursively
output: (No output, deletes ~/testdir)

rm -f ~/testfile # Forces removal of testfile without prompting
output: (No output, deletes ~/testfile)

cp ~/testfile ~/testfile_copy # Copies testfile to testfile_copy
output: (No output, creates ~/testfile_copy)

cp -i ~/testfile ~/testfile_copy # Copies interactively (prompts if overwrite)
output: (e.g., cp: overwrite ‘~/testfile_copy’? (y/n))

cp -r ~/testdir ~/testdir_copy # Copies testdir recursively to testdir_copy
output: (No output, creates ~/testdir_copy)

mv ~/testfile_copy ~/testfile_moved # Moves or renames testfile_copy to testfile_moved
output: (No output, renames file)

mv -i ~/testfile_moved ~/testfile # Moves interactively (prompts if overwrite)
output: (e.g., mv: overwrite ‘~/testfile’? (y/n))

# --- Sorting Data ---
sort ~/testfile # Sorts text in testfile (assuming it has lines)
output: (Sorted lines, e.g., apple banana cherry)

sort -k 2 ~/testfile # Sorts by the second field
output: (Sorted by field 2, depends on file content)

sort -r ~/testfile # Sorts in reverse order
output: (e.g., cherry banana apple)

sort -u ~/testfile # Sorts and removes duplicates
output: (Unique sorted lines, e.g., apple banana)

# --- Creating a Collection of Files (tar) ---
tar -cf myarchive.tar *.sh # Creates a tar archive of .sh files
output: (No output, creates myarchive.tar)

tar -xf myarchive.tar # Extracts files from myarchive.tar
output: (No output, extracts files)

tar -tf myarchive.tar # Lists contents of myarchive.tar
output: (e.g., learn_commands.sh)

tar -cvzf myarchive.tar.gz *.sh # Creates a compressed tar archive verbosely
output: (e.g., learn_commands.sh)

# --- Compressing Files ---
gzip ~/testfile # Compresses testfile to testfile.gz
output: (No output, creates ~/testfile.gz)

gunzip ~/testfile.gz # Uncompresses testfile.gz back to testfile
output: (No output, restores ~/testfile)

gzcat ~/testfile.gz # Concatenates and displays compressed testfile
output: (Contents of testfile, if it existed)

zcat ~/testfile.gz # Concatenates and displays compressed testfile
output: (Contents of testfile, if it existed)

# --- Disk Usage ---
du ~/scripts # Estimates file usage in scripts directory
output: (e.g., 12 /home/yourusername/scripts)

du -k ~/scripts # Displays sizes in kilobytes
output: (e.g., 12 /home/yourusername/scripts)

du -h ~/scripts # Displays sizes in human-readable format
output: (e.g., 12K /home/yourusername/scripts)

# --- Wildcards ---
dir *.sh # Lists all .sh files in current directory using wildcard
output: (e.g., learn_commands.sh myscript.sh)

dir file[1-3] # Lists files matching pattern file1, file2, file3
output: (e.g., file1 file2 file3)

# --- I/O Redirection ---
dir > ~/dir_output.txt # Redirects standard output to a file (overwrites)
output: (No output, creates/overwrites ~/dir_output.txt with dir listing)

dir >> ~/dir_output.txt # Appends standard output to a file
output: (No output, appends dir listing to ~/dir_output.txt)

wc -l < ~/dir_output.txt # Redirects input from a file to a command (word count lines)
output: (e.g., 5 ~/dir_output.txt)

dir here not-here 2> ~/errors.txt # Redirects standard error to a file
output: (e.g., here; errors in ~/errors.txt: dir: not-here: No such file)

dir here not-here > ~/output.txt 2>&1 # Combines stderr and stdout to a file
output: (No output, both output and errors go to ~/output.txt)

dir > /dev/null # Redirects output to nowhere (null device)
output: (No output, discards dir listing)

# --- Comparing Files ---
echo -e "line1\nline2\n diff here" > ~/file1.txt # Creates file1 for comparison
output: (No output, creates ~/file1.txt)

echo -e "line1\nline2\n DIFF HERE" > ~/file2.txt # Creates file2 for comparison
output: (No output, creates ~/file2.txt)

diff ~/file1.txt ~/file2.txt # Compares two files
output: (e.g., 3c3 < diff here --> DIFF HERE)

sdiff ~/file1.txt ~/file2.txt # Side-by-side comparison of two files
output: (e.g., diff here      |    DIFF HERE)

# vimdiff ~/file1.txt ~/file2.txt # Highlights differences in vim (commented; run manually)
# output: (Opens vim with highlighted diffs; :qa to quit)

# --- Searching in Files Using Pipes ---
grep "line" ~/file1.txt # Displays lines matching pattern "line"
output: (e.g., line1 line2)

grep -i "LINE" ~/file1.txt # Ignores case in search
output: (e.g., line1 line2)

grep -c "line" ~/file1.txt # Counts occurrences of pattern
output: (e.g., 2)

grep -n "line" ~/file1.txt # Precedes output with line numbers
output: (e.g., 1:line1 2:line2)

grep -v "diff" ~/file1.txt # Inverts match, prints non-matching lines
output: (e.g., line1 line2)

file ~/file1.txt # Displays file type
output: (e.g., /home/yourusername/file1.txt: ASCII text)

strings /bin/bash # Displays printable strings in binary file
output: (e.g., BASH_VERSION GNU bash)

cat ~/file1.txt | grep "line" # Pipes cat output to grep
output: (e.g., line1 line2)

cut -d " " -f 1 ~/file1.txt # Cuts first field using space delimiter
output: (e.g., line1 line2 diff)

dir | more # Pipes dir output to more for pagination
output: (Paginated dir listing; press q to quit)

# --- Transferring and Copying Files ---
# scp ~/file1.txt user@remote:/path # Copies file to remote (commented; requires setup)
# output: (No output, copies file to remote)

# sftp user@remote # Starts secure file transfer session (commented; requires setup)
# output: (Interactive session; type exit to quit)

ftp ftp.example.com # Starts file transfer session (commented; requires setup)
output: (Interactive session; type bye to quit)