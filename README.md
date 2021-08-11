# Tiler.spoon

Spoon for Tiling your windows on a Mac!

## Getting started

0. Get started with [Hammerspoon](https://www.hammerspoon.org). Follow the **Setup** section on [Getting Started with Hammerspoon](https://www.hammerspoon.org/go/) page.

1. Find your hammerspoon script directory. It will likely be `$HOME/.hammerspoon` after installation.

1. Download and save `Tiler.spoon` directory as:
`your-hammerspoon-path/Spoons/Tiler.spoon`

1. In your `init.lua` file, you should import the spoon as follows:
```lua
hs.loadSpoon('Tiler')
```

Reload your hammerspoon config and you're ready to go 😎

## How to Use

You can move or resize focused window using breakpoints that are calculated based on the aspect ratio of the screen.

### Move Window

Move focused window by holding `ctrl option cmd` and pressing the breakpoint `key`


**Regular**

| Key | Window X offset |
| ---- | -------- |
| T | 1/3 screen |
| H | 1/2 screen |
| 2 | 2/3 screen |

**Wide**

| Key | Window X offset |
| ---- | -------- |
| Q | 1/4 screen |
| T | 1/3 screen |
| H | 1/2 screen |
| 2 | 2/3 screen |
| 3 | 3/4 screen |


### Resize Window

Resize focused window by holding `ctrl option cmd shift` and pressing the breakpoint `key`

**Regular**

| Key | Window Width |
| ---- | -------- |
| T | 1/3 screen |
| H | 1/2 screen |
| 2 | 2/3 screen |
| 0 | Full screen (window) |

**Wide**

| Key | Window Width |
| ---- | -------- |
| Q | 1/4 screen |
| T | 1/3 screen |
| H | 1/2 screen |
| 2 | 2/3 screen |
| 3 | 3/4 screen |
| 0 | Full screen (window) |
