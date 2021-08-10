local mod = { "cmd", "alt", "ctrl" }
local shiftMod = { "cmd", "alt", "ctrl", "shift"}

local obj = {}

obj.__index = obj

obj.name = "Tiles"
obj.version = "0.3.0"
obj.author = "Maxim Soukharev <maxim.soukharev@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"


local function getRatio(width, height, inverse)
    local inverse = inverse or false
    local r = width / height
    r = inverse and 1 / r or r
    return r
end

local function isWide(aspectRatio)
    if aspectRatio >= 2.3333 then
        return true
    else
        return false
    end
end

local function getSizeBreakpoints(aspectRatio)
    if isWide(aspectRatio) then
        return { 0.25, 0.333, 0.50, 0.666, 0.75, 1 }
    else
        return { 0.333, 0.5, 0.666, 1 }
    end
end

local function findNextUp(val, breakPoints)
    local nxt = val
    for _, n in ipairs(breakPoints) do
        if n > nxt + 0.01 then
            nxt = n
            break
        end
    end
    return nxt
end

local function findNextDown(val, breakPoints)
    local nxt = val
    for _, n in ipairs(breakPoints) do
        if n < val - 0.01 then
            nxt = n
        else
            break
        end
    end
    return nxt
end

local function resize(direction)
    local win = hs.window.focusedWindow()
    local wRect = win:frame()
    local sRect = win:screen():frame()

    local winWidthRatio = getRatio(wRect.w, sRect.w)
    local scrAsp = getRatio(sRect.w, sRect.h)

    local breaks = getSizeBreakpoints(scrAsp)
    local newRatio
    if direction == "Left" then
        newRatio = findNextDown(winWidthRatio, breaks)
    elseif direction == "Right" then
        newRatio = findNextUp(winWidthRatio, breaks)
    end
    local winUnitRect = wRect:toUnitRect(sRect)
    winUnitRect.w = newRatio
    win:move(winUnitRect)
end

local function setWindowPosition(direction, screen, win)
    local screenFrame = screen:frame()
    local winFrameUnit = win:frame():toUnitRect(screenFrame)
    local newX
    if direction == "Left" then
        newX = math.max(0, winFrameUnit.x - winFrameUnit.w)
    elseif direction == "Right" then
        newX = math.min(1 - winFrameUnit.w, winFrameUnit.x + winFrameUnit.w)
    end
    winFrameUnit.x = newX
    win:move(winFrameUnit)
end

local function move(direction)
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    setWindowPosition(direction, screen, win)
end

local directions = { "Left", "Right" }

for _, direct in ipairs(directions) do
    hs.hotkey.bind(mod, direct, function ()
        resize(direct)
    end)
    hs.hotkey.bind(shiftMod, direct, function ()
        move(direct)
    end)
end

return obj
