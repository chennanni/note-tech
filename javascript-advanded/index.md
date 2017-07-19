---
layout: default
title: Javascript Advanced
folder: javascript-advanced
permalink: /archive/javascript-advanced/
---

# Javascript Advanced

## Equals

"==" vs "===" AND "!=" vs "!=="

- 三等号需要类型和值都相等
- 双等号只要求值相等，如果类型不同会做转换

> when two operands are of the same type and have the same value, then === produces true and !== produces false; 
when the operands are of the same type, but if they are of different types, == and != attempt to coerce the values

Example

```
100 == "100"  // true
100 === "100" // false

0 == ''   // true
0 === ''  // false
```

## Quotes

double quotes "" vs single quotes ''

- There is no special difference between single and double quotes.

(You don't need to escape single quotes in double quotes, or double quotes in single quotes)
