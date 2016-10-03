---
layout: default
title: Java - GUI
folder: gui
permalink: /archive/java/gui/
---

# Java GUI

## Desktop GUI applications

- AWT(Abstract Window Toolkit)
- Swing(Java Foundation Classes)
  - Pluggable Look and Feel
  - Platform Independent components
  - Enhanced component library
  
## Swing v.s. AWT
- AWT is a Java interface to native system GUI code present in your OS. It will not work the same on every system, although it tries.
- Swing is a more-or-less pure-Java GUI. It uses AWT to create an operating system window and then paints pictures of buttons, labels, text, checkboxes, etc., into that window and responds to all of your mouse-clicks, key entries, etc., deciding for itself what to do instead of letting the operating system handle it.
- Thus Swing is 100% portable and is the same across platforms.
  
## AWT Packages

- java.awt 
	- GUI container classes
		- Frame
		- Panel
		- Dialog
		- ScrollPane
	- GUI component classes
		- Button
		- TextField
		- Label
	- Layout managers
		- BorderLayout (Positions), default for Frame
		- FlowLayout (Alignments), default for Panel / Applet
		- GridLayout
		- CardLayout, add panels/cards one behind the other
		- NullLayout, custom
	- Custom graphics classes
		- Graphics
		- Color
		- Font

- java.awt.event
	- Event classes
		- ActionEvent
		- MouseEvent
		- KeyEvent
		- WindowEvent
	- Event listener interfaces
		- ActionListener
		- MouseListener
		- KeyListener
		- WindowListener
	- Event listener adapter classes
		- MouseAdapter
		- KeyAdapter
		- WindowAdapter

### Container

Top Lever Containers

- Frame
- Dialog
- Applet

Secondary Containers

- Panel
- ScrollPane

### Frame

By default, frame's size is (0,0) and visibility is false;

```
f = new Frame();
f.setSize(500, 500);
f.setVisible(true);
```

### Event Handing
- Component (source/listener object)
	- Button
	- Label
	- List
	- Checkbox
	- Choice
	- TextField
- Event
- Listener

**Work Flow**

- create Source Object (e.g. create a button)
- create Listener Object (e.g. implement listener interface, override actionperformed method)
- register Listener to Source (e.g. button.addActionListener(l))
- wait for user to trigger the ActionListener -> (e.g. button create a new Event and invoke the actionperformend mehtod of the Lister Object)

![java_awt_flow](img/java_awt_flow.png)

notice: Listener interfaces are abstract, must override all methods; to avoid using interface, we can use(extends) the adapter (class)

## Links
- [Java Programming Tutorial(GUI)](https://www3.ntu.edu.sg/home/ehchua/programming/java/J4a_GUI.html)
