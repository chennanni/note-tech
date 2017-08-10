---
layout: default
title: Java - Questions
folder: questions
permalink: /archive/java/questions/
---

# Java - Questions

## Hashtable vs HashMap vs ConcurrentHashMap
- Hashtable is synchronized, whereas HashMap is not.
- Hashtable does not allow null keys or values. HashMap allows one null key and any number of null values.
- Hashtable has locks on all operations, whereas ConcurrentHashMap does not lock on `get()`. And ConcurrentHashMap
- ConcurrentHashMap is more efficient for threaded applications.

<https://stackoverflow.com/questions/12646404/concurrenthashmap-and-hashtable-in-java>
