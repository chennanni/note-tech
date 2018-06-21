---
layout: default
title: Machine Learning - Basic
folder: basic
permalink: /archive/ml/basic/
---

# W1 - Introduction

## What is Machine Learning

Arthur Samuel described it as: "the field of study that gives computers the ability to learn without being explicitly programmed."

## Example

- Database mining
  - Large datasets from growth of automation/web, web click data, medical records, biology, engineering
- Applications can’t program by hand.
  - Autonomous helicopter, handwriting recognition, Natural Language Processing (NLP)
- Self-customizing programs
  - Amazon, Netflix product recommendations

## Supervised Learning

Know what our correct output should look like, having the idea that there is a relationship between the input and the output.

Two types
- Regression: predict continuous valued output (price)
- Classification: discrete valued output (0 or 1)

## Unsupervised Learning

Approach problems with little or no idea what our results should look like.

# W1 - Linear Regression with One Variable

## Model Representation

build a mathematic model to represent the real problem

Example: y(x)=ax+b

## Cost Function

a way to evaluate the distance between estimate and real values

![ml-cost-function-1](img/ml-cost-function-1.png)

## Gradient Descent

Have cost function: J(s0,s1), want to get min(J) -> keep change s0,s1 to achive the local minimum.

Intuition

![ml-gradient-descent-3](img/ml-gradient-descent-3.png)

Algorithm

![ml-gradient-descent-2](img/ml-gradient-descent-2.png)

# W2 - Linear Regression with Multiple Variables

TODO

# Source
- All materials come from [Machine Learning](https://www.coursera.org/learn/machine-learning) offered by Andrew Ng, Stanford University
