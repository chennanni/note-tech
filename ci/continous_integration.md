---
layout: default
title: CI
folder: ci
permalink: /archive/ci/
---

# Continous Intergration

Continuous Integration (CI) is a development practice that requires developers to **integrate code into a shared repository several times a day**.

Each check-in is then verified by an automated build, allowing teams to detect problems early.

## Motivation
When many people are working on a project in parallel, there's an "intergration problem"

- Merge conflicts
- Compile conflicts
- Test confilicts

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

- Jenkins
- Bamboo
- Snap CI
- Cruise Control

## Links

- http://www.thoughtworks.com/cn/continuous-integration
