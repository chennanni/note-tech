---
layout: default
title: Shell Scripting
folder: shell
permalink: /archive/shell/
---

# Shell Scripting (Linux)

## What is Linux?
- Free
- Unix Like
- Open Source
- Network oprating system

## Where can I use Linux?
- Linux Server
- Standalone workstation/PC

## What is Kernal?
- Kernel is heart of Linux Os.
- It acts as an intermediary between the computer hardware and various programs/application/shell.

## What is Shell?
- Shell is a user program or it's environment provided for user interaction.

## Linux/Unix commands

navigation => **cd**, **ls**, **pwd**, **clear**

```
cd [doc], change direcotry to doc
cd /, change into the root directory
cd .., change into the parent directory
cd ~, change into the home directory

ls, list files and directories
ls -a, list all files and directories
ls -l, list the total files in the directory and subdirectories, one file per line

pwd, display the path of the current directory

clear, clear the screen
```

file manipulation => **mkdir**, **cp**, **mv**, **rm**, **rmdir**

```
mkdir [directory], create a directory/folder

cp [file1] [file2], copy file1 and call it file2

mv [file1] [file2], move or rename file1 to file2

rm [file], remove a file
rm -rf [foldername], recursively force remove the folder and everything in it

rmdir [foldername], remove a folder
```

file read => **cat**, **less**, **head**

```
cat [file], display a file

less [file], display a file a page at a time

head [file], display the first few lines of a file

tail [file], display the last few lines of a file
tail -100f [file], constantly display the last 100 lines of a file
```

file write => **redirect**, **cat**, **emacs/vim**

```
command > file, redirect standard output to a file
command >> file, append standard output to a file
command < file, redirect standard input from a file

cat [file1] [file2] > [file0], concatenate file1 and file2 to file0

emacs/vim [file], launches the emacs/vim editor, and opens the file for editing
```

file search => **grep**, **wc**, **wildcards**

```
grep [keyword] [file], search keyword in a file, default case sensitive
grep -i [keyword] [file], ignore upper/lower case

wc [file], count number of lines/words/characters in file
wc -w [file], count words of a txt file
wc -l [file], count lines of a txt file

ls *list, list all files in the current dir starting with list...
ls list*, list all files in the current dir ending with ...list
ls ?list, match exactly one character
```

permission => **chmod**, **sudo**

```
chmod XXX [file], change the permissions of files or directories.
chmod u=rw [file], the owner may read and write the file

sudo, allows a permitted user to execute a command as the superuser or another user
```

check process => **ps**, **top**, **kill**, 

```
ps, report process status
ps grep ['pwd'], show process matching pattern 'pwd'
ps [aux]
// a = show processes for all users
// u = display the process's user/owner
// x = also show processes not attached to a terminal

top, display top CPU processes

kill [%1], kill job number 1
kill [26152], kill process number 26152
```

help => **man/apropos**, **who**

```
man [command], read the manual of a command
whatis [command], show one-line description of a command
apropos [keyword], not sure of the exact name of a command

who | sort, list logged-in user and sort the result
```

## Links
- [Unix Tutorial](http://www.ee.surrey.ac.uk/Teaching/Unix/)
- [Linux and Unix top 10 commands](http://www.computerhope.com/unixtop1.htm)
- [Linus Shell 编程](http://www.cnblogs.com/xuqiang/archive/2011/04/27/2031034.html)
- <http://www.freeos.com/guides/lsst/index.html>
- <http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html>
