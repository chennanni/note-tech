---
layout: default
title: Dev Tools - Draw
folder: draw
permalink: /archive/dev/draw/
---

# Dev Tools - Draw

程序员常用的几种图：
- 架构图
- 流程图
- ER图
- 类图
- 时序图

在实际使用过程中，根据具体情况，画1-2种图即可，再多也没有必要。

## 架构图
Arch Diagram

![[arch_diagram.PNG]]

工具：
- drawio
	- https://app.diagrams.net/
- wps
	- https://www.wps.cn/

## 流程图
Workflow Diagram

![[workflow_diagram.PNG]]

工具：
- drawio
	- https://app.diagrams.net/
- wps
	- https://www.wps.cn/

笔者认为：使用“拖拽式”的编辑方式，更直观、高效。只需符合两点：
- 自己要保存好底稿，便于日后修改
- 平台/软件可以长期使用

## ER图
Entit Relationship Diagram

![[er_diagram.PNG]]

工具：
- drawio
	- https://app.diagrams.net/
- wps
	- https://www.wps.cn/

笔者认为：ER图相当于是在类图的基础上做一层抽象。不关心具体的细节，而是从宏观角度思考所有的对象。

## 类图
Class Diagram

![[draw_class_diagram.png]]

工具：plantuml
网址：https://plantuml.com/
语法：https://plantuml.com/class-diagram/

使用时，往往配合 IntelliJ 的插件：
- PlantUML Integration - 预览图片内容，语法检查，类似editor一样
- PlantUML Parser - 选定一些文件直接生成类图

图标含义
- 实线：继承（燕子 -> 鸟）
- 虚线：实现（鸟 -> 飞翔）
- 实心：包含（鸟 -> 翅膀）
- 空心：聚合（鸟 -> 鸟群）
参考-> https://baijiahao.baidu.com/s?id=1719410317740261286

## 时序图
Sequence Diagram

![[draw_seq_diagram.PNG]]

工具：plantuml
网址：https://plantuml.com/
语法：https://plantuml.com/sequence-diagram/

## 其他备选工具
- processon
- draw.io
- excalidraw
- archimatetool
- cloudcraft.co
