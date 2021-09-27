---
layout: default
title: Editor - Vim
folder: vim
permalink: /archive/editor/vim/
---

# Editor - Vim

## Mode

- command mode
  - type `i` -> insert mode
  - type `:` -> last-line mode
- insert mode
  - click `Esc` -> command mode
- last-line mode

## Navigation

- in command mode
  - `G` moves to the last line.
  - `gg`moves to the first line.
  - `0` moves to beginning of line.
  - `$` moves to end of line.
- in command mode
  - 上下左右：
    - use arrow key
    - `k`, `j`, `h`, `l`
  - 翻页上：
    - `PGUP`
    - `Ctrl+B`
  - 翻页下：
    - `PGDN`
    - `Ctrl+F`

## Editing

- in command mode
  - `dw` will delete a character.
  - `dd` will delete a line.
  - `u` will undo the last operation.
  - `Ctrl-r` will redo the last undo.

## Copy and Paste

- in command mode
  - `v` highlight one character at a time.
  - `y` copy text
  - `d` cut text
  - `p` paste text
  - `"+y` copy to system clipboard. 

refer to <https://vim.fandom.com/wiki/Copy,_cut_and_paste>

## Search

- in command mode
  - `/<String>` search for String
  - `n` go to next matching pattern
  - `N` go to previous matching pattern
- set search highlight color
  - `:set hlsearch`
  - `:nohlsearch`
- show line number
  - `:set number`

## Saving and Quiting

- in last line mode
  - `:w` for saving
  - `:w filename` for saving to another file
  - `:q` for quit
- in command mode
  - `ZZ` for saving and quit

## Re-format a long line

- First set your vim so that it understands that you want 80 characters:`:set tw=80`
- then, hilight the line:`V`
- and make vim reformat it:`gq`
