---
layout: default
title: CI/CD
folder: basic
permalink: /archive/ci-cd/basic
---

# CI/CD
## Continous Intergration
自动化 持续 集成（包括 BUILD，UT，发布等）

> Continuous Integration (CI) is a development practice that requires developers to **integrate code into a shared repository several times a day**.
> 
> Each check-in is then verified by an automated build, allowing teams to detect problems early.

## Continous Deployment
自动化 持续 部署

> Continous Deployment (CD) is to accomodate with CI, when new packages are ready, automatically deploy them to servers.

## Motivation / Why
When many people are working on a project in parallel, there's an "intergration problem"
- Merge conflicts
- Compile conflicts
- Test confilicts

简单来说，是为实现：“我” commit 完代码，很快就能部署上开发环境并测试。有没有问题，立刻知道。

具体地说，是为了解决多人协作时的代码合并问题，提高开发效率。

## How to do it

Phase 1
- Developers check out code into their private workspaces.
- When done, the commit changes to the repository.

Phase 2
- The CI server monitors the repository and checks out changes when they occur.
- The CI server builds the system and runs unit and integration tests.
- The CI server releases deployable artefacts for testing.
- The CI server assigns a build label to the version of the code it just built.
- The CI server informs the team of the successful build.

Phase 3
- If the build or tests fail, the CI server alerts the team.
- The team fix the issue at the earliest opportunity.

Phase 4
- Continue to continually integrate and test throughout the project.

## Tools
**CI / CD 平台**
- [[jenkins]]
- Bamboo
- Snap CI
- Cruise Control

**容器化**
- [[docker]]
- kubernates

## Links
- http://www.thoughtworks.com/cn/continuous-integration
