---
layout: default
title: Editor - Emacs
folder: basic
permalink: /archive/editor/emacs/
---

# Emacs

C-Ctrl
<br>
M-Alt

Moving Cursor
- Next page: `C-v`
- Prev page: `M-v`
- Center cursor: `C-l`
- Move cursor: 

```
move by char, back/forward
C-b    C-f
move by word, back/forward
M-b    M-f

C-p: move to the previous line
C-n: move to the next line

C-a: move to the beginning of the line 
C-e: move to the end of the line

M-a: move to the beginning of the sentence
M-e: move to the end of the sentence

C-<: move to the beginning of the text
C->: move to the end of the text
```

Functional
- Quit command: `C-g`
- End Session: `C-x`+`C-c`
- Number of command: `C-u`+`#`

Multiple window
- Split to 2 windows: `C-x`+`2`
- Back to 1 window: `C-x`+`1`
- Move cursor to the other window: `C-x`+`o`
- Scroll down the other window: `C-M-v`

Multiple frame
- Add a new frame: `M-x`+`"make frame"`+`<ENTER>`
- Delete a frame: `M-x`+`"delete frame"`+`<ENTER>`

Search
- Search forward: `C-s`
- Search backward: `C-r`

Delete/Copy/Paste/Undo
- Delete one char before cursor: `<DEL>`
- Delete one char after cursor: `C-d`
- Kill one word before cursor: `M-<DEL>`
- Kill one word after cursor: `M-d`
- Kill from cursor to the end of the line: `C-k`
- Kill form cursor to the end of the sentence: `M-k`
- Kill from point A to point B: `C-w`
- Mark point A: `C-<SPACE>`
- Mark point B: `move cursor to point B`
- Paste: "C-y"
- Undo: "C-/"

File
- Find file: `C-x`+`C-f`
- Save file: `C-x`+`C-s`

Buffer
- List all buffers: `C-x`+`C-b`
- Switch buffer: `C-x`+`b`
- Save buffer: `C-x`+`s`
