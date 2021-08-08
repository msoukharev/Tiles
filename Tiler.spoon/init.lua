local mod = { "cmd", "alt", "ctrl" }

local obj = {}

obj.__index = obj

obj.name = "Tiler"
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
        return { 0.25, 0.33, 0.50, 0.66, 0.75, 1 }
    else
        return { 0.33, 0.5, 0.66, 1 }
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

local directions = { "Left", "Right" }

for _, direct in ipairs(directions) do
    hs.hotkey.bind(mod, direct, function ()
        resize(direct)
    end)
end

return obj
