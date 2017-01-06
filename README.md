## Spunto
Lightweight replacement for Punto Switcher's manual mode that doesn't spy on you.

![](/demo.gif)

### Installation
Spunto is a plugin for [Hammerspoon](http://hammerspoon.org/). Once Hammerspoon is installed place the following into your `~/.hammerspoon/` directory
* spunto.lua
* spunto/en-ru.txt (if necessary)

after that add the followoing to somewhere on top of your `~/.hammerspoon/init.lua`
```
dofile("spunto.lua")
```

### Usage
By default Spunto comes only with support of MBPr 13" Russian keyboard layout.
But it can be easily modified by adding new layouts to `spunto/` directory (see `en-ru.txt` as an example) and changing DICT_PATH in `spunto.lua`

Once you finished up with your layout text file, you are ready to start.

By default:

* Press `F3` to change selected text or the last word if nothing is selected.
* Press `⌘ + F3` to change whole line to the left of the cursor.

Hotkeys can be changed at the bottom of `spunto.lua`

### Requirements
* OS X El Capitan or newer
* Hammerspoon v0.9.52 or higher
* Accessibility Settings must be enabled for Hammerspoon

### License
    The MIT License (MIT)
    
    Copyright (c) 2017 Ilya Trofimov
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE   
