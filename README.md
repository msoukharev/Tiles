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

You can activate command keys by holding `ctrl opt cmd`. The command keys allow you to select desirable window configuration.

| Key | Command |
| --- | --- |
| `0` | Window size on long axis |
| `-` | Window position |
| `=` | Window size and position on short axis |
| `/` | Combined: Window size, position on long axis, window size and position along the short axis |
