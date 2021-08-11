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

local mapY = {
    [']'] = 0.5,
    ['='] = 0.0,
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

local mapH = {
    ['='] = 0.5,
    [']'] = 1
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

local function getBreakpointX(key, screen)
    if isWide(screen) then
        return wideMapX[key]
    else
        return mapX[key]
    end
end

local function getBreakpointY(key, screen)
    return mapY[key]
end

local function getBreakpointW(key, screen)
    if isWide(screen) then
        return wideMapW[key]
    else
        return mapW[key]
    end
end

local function getBreakpointH(key, screen)
    return mapH[key]
end

local function getFocusedWindowWithScreen()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    return win, screen
end


local function setWindowSize(win, screen, w, h)
    local screenFrame = screen:frame()
    local winFrameUnit = win:frame():toUnitRect(screenFrame)
    winFrameUnit.w = w or winFrameUnit.w
    winFrameUnit.h = h or winFrameUnit.h
    win:move(winFrameUnit)
end

local function setWindowPosition(win, screen, x, y)
    local screenFrame = screen:frame()
    local winFrameUnit = win:frame():toUnitRect(screenFrame)
    winFrameUnit.x = x or winFrameUnit.x
    winFrameUnit.y = y or winFrameUnit.y
    win:move(winFrameUnit)
end

for key, _ in pairs(wideMapX) do
    hs.hotkey.bind(mod, key, function ()
        local win, screen = getFocusedWindowWithScreen()
        local x = getBreakpointX(key, screen)
        if x ~= nil then
            setWindowPosition(win, screen, x, nil)
        end
    end)
end

for key, _ in pairs(mapY) do
    hs.hotkey.bind(mod, key, function ()
        local win, screen = getFocusedWindowWithScreen()
        local y = getBreakpointY(key, screen)
        setWindowPosition(win, screen, nil, y)
    end)
end

for key, _ in pairs(wideMapW) do
    hs.hotkey.bind(shiftMod, key, function ()
        local win, screen = getFocusedWindowWithScreen()
        local w = getBreakpointW(key, screen)
        setWindowSize(win, screen, w, nil)
    end)
end

for key, _ in pairs(mapH) do
    hs.hotkey.bind(shiftMod, key, function ()
        local win, screen = getFocusedWindowWithScreen()
        local h = getBreakpointH(key, screen)
        setWindowSize(win, screen, nil, h)
    end)
end


return obj
