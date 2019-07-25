# Dev Ops

## What

Dev Ops -> Development & Operations 

从软件工程的流程来看，实际是三个环节 -> 开发、测试（QA）和运维。

## Why

根据过去的经验，这两者往往是分开的两个岗位。“他们工作地点分离，工具链不同，业务目标也有差异，这使得他们之间出现一条鸿沟。”

开发更关注功能实现，尽快交付需求。
运维更关注系统的稳定性，别老是半夜被call起来解决问题。

Dev Ops概念的提出，就是为了强调开发和运维的沟通合作，“通过自动化流程来使得软件构建、测试、发布更加快捷、频繁和可靠。”

## Understanding

两者紧密合作，可以提高生产力。
- 比如，运维监测生产环节时，发现有一些性能优化的空间，于是把问题提给开发来解决，未雨绸缪。
- 再比如，开发为了方便测试做了一些小工具，这些knowledge可以传授给运维用于生产环节的监测。

开发和运维的协作。这种协作，可以通过几种方法实现：
- 把开发和运维集合成一个岗位。（初创公司往往就是这么做的）
- 通过各种工具，加强两者的联系。

## Tools

Env
- Docker
- Kubernetes

Repo
- Git

Build
- Gradle

Test
- Selenium

Deploy
- Jenkins
- Bamboo

Monitor
- Nagios
- Raygun

## Links

- [目前最流行的开发模式DevOps究竟是什么鬼](https://blog.csdn.net/bntX2jSQfEHy7/article/details/79168865)
- [2019十大最佳DevOps工具](http://dockone.io/article/8507)
