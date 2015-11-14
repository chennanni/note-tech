---
layout: default
title: Fitneese
permalink: /fitneese/
---

# FitNesse

## What is FitNesse
FitNesse is a testing tool(bridge) between developers and customers(testers). For customers,
they create acceptance test cases(tables). The tables call "fixtures"(which is built by developers) to test against the real code.

FitNesse has two flavors: Fit and Slim. They are the core implementations behind the scene.

<http://fit.c2.com/wiki.cgi?IntroductionToFit>

## Fit VS Slim

Slim is a light version for Fit. Fit takes in HTML and output HTML as result while Slim leaves the HTML processing, comparisons, and colorizing to FitNesse.

~~~
          instruction list
+----------+    o--->     +------------+      +----------+       +-----+
| FitNesse |---[socket]-->| SlimServer |----->| Fixtures |------>| SUT |
+----------+    <---o     +------------+      +----------+       +-----+
            response list
~~~

<http://www.fitnesse.org/FitNesse.UserGuide.WritingAcceptanceTests.SliM.SlimProtocol>

## Set up
- download fitnesse-standalone.jar into a folder
- cmd into this folder, type `java -jar fitnesse-standalone.jar [-p portNumber]`
- open a browser and go to localhost:<port #>

## Links
- <http://www.fitnesse.org/>
- <http://fit.c2.com/>
