local mod = { "cmd", "alt", "ctrl" }
local shiftMod = { "cmd", "alt", "ctrl", "shift"}

local obj = {}

obj.__index = obj

obj.name = "Tiles"
obj.version = "0.4.0"
obj.author = "Maxim Soukharev <maxim.soukharev@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"


local wideMapX = {
    ['1'] = 0,
    ['2'] = 0.25,
    ['3'] = 0.333,
    ['5'] = 0.50,
    ['6'] = 0.666,
    ['7'] = 0.75
}

local mapX = {
    ['1'] = 0,
    ['3'] = 0.333,
    ['5'] = 0.50,
    ['6'] = 0.666
}

local wideMapW = {
    ['2'] = 0.25,
    ['3'] = 0.333,
    ['5'] = 0.5,
    ['6'] = 0.666,
    ['7'] = 0.75,
    ['0'] = 1
}

local mapW = {
    ['3'] = 0.333,
    ['5'] = 0.5,
    ['6'] = 0.666,
    ['0'] = 1
}

local function isWide(screen)
    local frame = screen:frame()
    local aspectRatio = frame.w / frame.h
    if aspectRatio >= 2.3333 then
        return true
    else
        return false
    end
end

local function getPosBreakpointFromKey(key, screen)
    if isWide(screen) then
        return wideMapX[key]
    else
        return mapX[key]
    end
end

local function getWindowSizeFromKey(key, screen)
    if isWide(screen) then
        return wideMapW[key]
    else
        return mapW[key]
    end
end


local function setWindowSize(win, screen, w)
    local screenFrame = screen:frame()
    local winFrameUnit = win:frame():toUnitRect(screenFrame)
    winFrameUnit.w = w
    win:move(winFrameUnit)
end

local function setWindowPosition(win, screen, x)
    local screenFrame = screen:frame()
    local winFrameUnit = win:frame():toUnitRect(screenFrame)
    winFrameUnit.x = x
    win:move(winFrameUnit)
end

local function moveWindow(key)
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local x = getPosBreakpointFromKey(key, screen)
    print(x)
    if x ~= nil then
        setWindowPosition(win, screen, x)
    end
end

local function resizeWindow(key)
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local w = getWindowSizeFromKey(key, screen)
    print(w)
    if w ~= nil then
        setWindowSize(win, screen, w)
    end
end


for key, _ in pairs(wideMapX) do
    hs.hotkey.bind(mod, key, function ()
        moveWindow(key)
    end)
end

for key, _ in pairs(wideMapW) do
    hs.hotkey.bind(shiftMod, key, function ()
        resizeWindow(key)
    end)
end

return obj
