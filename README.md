---
published: false
---

@ auto built using <https://www.travis-ci.com/> (migrate from travis-ci.org) 

# My Tech Note

This is the place where I keep my tech note. 
- Check `index.md` of each topic to see the content.
- Check `src` under each project to see examples.
- Check `web-build.md` to see the details of building up this project.

## Front Matter

> The front matter is where Jekyll starts to get really cool. 
Any file that contains a YAML front matter block will be processed by Jekyll as a special file.

Example: root

~~~
---
layout: default
title: AJAX
folder: ajax
permalink: /archive/ajax/
---
~~~

Example: sub-folder

~~~
---
layout: default
title: Java - Basic
folder: basic
permalink: /archive/java/basic/
---
~~~

## Markdown Note

There's some small differences between kramdown and github-flavor markdown. Thus, the page rendered on github and github-pages may be different. To make sure consistancy, follow some special rules: 

https://github.com/chennanni/note-cheat-sheet/blob/master/cs-jekyll.md

## Updates

- 2018/09/28 | v1.1: Add table of content function. - refer [jekyll-toc](https://github.com/allejo/jekyll-toc)
