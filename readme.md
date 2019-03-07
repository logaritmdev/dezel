<img src="https://github.com/logaritmdev/dezel/blob/master/logo.svg" alt="Dezel" width="320">

Dezel is a framework for building native cross platform mobile applications.

## Introduction

The Dezel framework is a native mobile application platform whose primary goal is to improve productivity without sacrificing performance. Dezel applications are written in **TypeScript**.

## Core concepts

### Good performance
In order to achieve good performance, all the heavy lifting stuff such as **layout calculations**, **style resolutions**, **animations** are done natively. The TypeScript code is a thin layer sitting on top of that.

### Fast development
Dezel makes development faster by making your code truly cross platform and by providing unified solutions to common development problems. Some of these are:

 - A unified layout system that supports:
    - Absolute positioning,
    - Flexbox like positioning,
    - Paddings,
    - Margins,
    - Borders,
    - min/max for width, height, padding, margin,
    - All of the above in a wide range of units (px, %, vw, vh, pw, ph...),
    - and more...

- A unified drawing system that supports:
    - Four colors borders,
    - Separated border radiuses,
    - Shadows,
    - Background images.
    - and more...

 - Lists with infinite scrolling support.

### Styling

Dezel supports a styling syntax that is very similar to CSS. This has many advantages such as having cleaner code, overridable styles and platform specific styles.

### Unified native API

It's also possible to bridge your own functionality. The native API used on Android and iOS is very similar to a point where porting native code to the other platform is mostly a matter of doing some "Find and replace".

## Documentation
Documentation is currently being written. Stay tuned.

## Licence
MIT

## Thank You
David Bénicy for the Canvas code on Android