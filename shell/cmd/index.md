---
layout: default
title: Shell - Command
folder: cmd
permalink: /archive/shell/cmd
---

# Shell - Command (Linux)

## navigation ## 

=> **cd**, **ls**, **pwd**, **clear**

```
cd [doc]: change direcotry to doc
cd /: change into the root directory
cd ..: change into the parent directory
cd ~: change into the home directory

ls: list files and directories
ls -a: list hidden files
ls -l: list in long (detailed) format
ls *<string>*: list files matching string

pwd: display the path of the current directory

clear: clear the screen
```

## file manipulation ## 

=> **mkdir**, **touch**, **cp**, **mv**, **rm**, **rmdir**

```
mkdir <directory>: create a directory/folder

touch <file-name>: create a new file

cp <source> <destination>: copy file to another location

mv <source> <destination>: move source to destination or rename

rm <file>: remove a file
rm -rf <foldername>: 'recursively' 'force' remove the folder and everything in it
rmdir <foldername>: remove a folder
```

## file read ##

=> **cat**, **sed**, **awk**, **more**, **less**, **head**

```
cat <file-name>: display file content
cat > <file-name>: create a new file, accept inputs from terminal, Ctrl+d to exit

sed: replace
sed 's/<string-1>/<string-2>/g' file-1 > file-2: stream editor, for file-1, replace string-1 with string-2, save to file-2
sed 's/<string-1>|<string-2>/<string-3>/g' file-1 > file-2: stream editor, for file-1, replace string-1 or string-2 with string-3, save to file-2
sed -i 's/<string-1>/<string-2>/' file-1.txt: use -i to edit files in-place instead of printing to standard output
sed -n 10,15p file.txt: show only lines 10-15 of file.txt

awk: find and replace item 
awk ' {print $1,$3} ': print only item one and three in each line using stdin
awk ' /'pattern'/ {print $2} ': print only elements from column 2 that match pattern using stdin

less <file>: display a file one page at a time, with scroll, search functions

head <file>: display the first few lines of a file
tail <file>: display the last few lines of a file
tail -n <num> <file>: see the last 'num' lines of a file
tail -f <file>: see the changes constantly
```

## file write ## 

=> **redirect**, **cat**, **emacs/vim**

```
command > file: redirect standard output to a file
command >> file: append standard output to a file
command < file: redirect standard input from a file

cat <file1> <file2> > <file0>: concatenate file1 and file2 to file0

emacs/vim <file>: launches the emacs/vim editor, and opens the file for editing
```

## file search ## 

=> **grep**, **wc**

```
grep <'string'> <file-name>: search file for the given string
grep <'string1'> <file-name> | grep <'string2'>: search for both string 1 and string 2
grep -E <'string1|string2'> <file-name>: search for string 1 or string 2

wc <file>: count number of lines/words/characters in file
wc -w <file>: count words of a txt file
wc -l <file>: count lines of a txt file
```

## permission ## 

=> **chmod**, **sudo**

```
chmod <XXX> <file>: change the permissions of files or directories.
chmod <u=rwx> <file>: the owner may read, write and execute the file

sudo: allows a permitted user to execute a command as the superuser or another user
```

## check process ##

=> **ps**, **top**, **kill**, **du**

~~~ shell
ps: show process status for the current user
ps grep <'pwd'>: show process matching pattern 'pwd'
ps <aux>
// a = show processes for all users
// u = display the process's user/owner
// x = also show processes not attached to a terminal
ps -eo user,pid,stat,%cpu,%mem,rss,args --sort rss | less

top: display top CPU processes

kill <%1>: kill job number 1
kill <26152>: generates the SIGTERM signal requesting process to terminate
kill -9 <26152>: generates the SIGKILL signal for process to terminate immediately or forcefully

du -hs * | sort -rh | head -n 5: show the top 5 folder size in current folder
  du command: Estimate file space usage.
    -h : Print sizes in human readable format (e.g., 10MB).
    -s : Display only a total for each argument.
  sort command : sort lines of text files.
    -r : Reverse the result of comparisons.
    -h : Compare human readable numbers (e.g., 2K, 1G).
    
df -h <path>: show the disk usage on current folder
~~~

## help ## 

=> **man/apropos**, **who**

```
man <command>: read the manual of a command
whatis <command>: show one-line description of a command
apropos <keyword>: not sure of the exact name of a command
type <cmd>: show cmd's alias

who | sort: list logged-in user and sort the result
```

## others ##

=> **xargs**

~~~ shell
xargs: build and execute command lines from standard input
echo --help | xargs cat: equals to cat --help
echo '1@2@3' | xargs -d '@' -n1 echo: divide input by @ and parse as parameter to cmd 1 by 1
cat input.txt | xargs -I {} echo {}: use {} to replace the input cmd
~~~

## Links

- [Linux and Unix top 10 commands](http://www.computerhope.com/unixtop1.htm)
- <http://www.freeos.com/guides/lsst/index.html>
