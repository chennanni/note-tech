---
layout: default
title: Git
folder: basic
permalink: /archive/git/basic
---

# Git

## Types of Verson Control System

- **Local** Version Control System
- **Centralized** Version Control System
- **Distributed** Version Control System

## General Steps of Version Control

- Check-out (pull)
- Adding file (add)
- Commit (commit)
- Check-in (push)
- Diff (merge)

## Git v.s. Others

Git store snapshots, not differences

## Three stages

- working directory
- staging area
- repository

![git_three_stages](git_three_stages.png)

## Life Cycle of File in the Working Directory

- in the beginning of check out, everything is **unmodified**
- then you edit the file, the file becomes **modified**
- then you stage the file, the file becomes **staged**
- finally you commit the file, the file becomes **unmodified**
- or you can remove the file, then the file becomes **untracked**

![git_lifecycle](git_lifecycle.png)


## Git Branching Model

long-term

- master
- develop

short-term

- feature
- release
- fix

read more
- <http://nvie.com/posts/a-successful-git-branching-model/>
- <http://nvie.com/files/Git-branching-model.pdf>


## Tools
- [[git-bash]]
- IDE embeded Git Tools
- [[tortoise-git]]
- Source Tree

## Misc

### add and use ssh key

```
https://help.github.com/articles/about-ssh/

add
step1 : generate an SSH key and add it to the ssh-agent
step2 : add the key to your GitHub account

use
specify the ssh key to use for a given repo: git config core.sshCommand "ssh -i ~/.ssh/id_rsa"
```

### save credential

If you’re using an HTTPS URL to push over, the Git server will ask you for your username and password for authentication. 
By default it will prompt you on the terminal for this information so the server can tell if you’re allowed to push.

If you don’t want to type it every single time you push, you can set up a “credential cache”. The simplest is just to keep it in memory for a few minutes, which you can easily set up by running `git config --global credential.helper cache`.
For more information on the various credential caching options available, see Credential Storage.

## Links
- <https://www.atlassian.com/git/tutorials/what-is-version-control>
- <https://git-scm.com/book/en/v2/Getting-Started-Git-Basics>
