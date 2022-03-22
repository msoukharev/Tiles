local mod = { "cmd", "alt", "ctrl" }

local obj = {}

obj.__index = obj
obj.name = "Tiles"
obj.version = "0.8.0"
obj.author = "Maxim Soukharev"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local normalAspect = {

    { text = '(lu) left upper',     urect = { 0, 0, 0.5, 0.5 } },
    { text = '(ll) left lower',     urect = { 0, 0.5, 0.5, 0.5 } },

    { text = '(ru) right upper',    urect = { 0.5, 0, 0.5, 0.5 } },
    { text = '(rl) right lower',    urect = { 0.5, 0.5, 0.5, 0.5 } },

    { text = '(lh) left half',      urect = { 0, 0, 0.5, 1 } },
    { text = '(rh) right half',     urect = { 0.5, 0, 0.5, 1 } },

    { text = '(lt) left third',    urect = { 0, 0, 0.3333, 1 } },
    { text = '(ct) center third',   urect = { 0, 0.3333, 0.3333, 1 } },
    { text = '(rt) right third',     urect = { 0, 0.6666, 0.3333, 1} }

}

local _2xApect = {

    { text = '(lu) left upper',     urect = { 0, 0, 0.3333, 0.5 } },
    { text = '(ll) left lower',     urect = { 0, 0.5, 0.3333, 0.5 } },

    { text = '(cu) center upper',    urect = { 0.3333, 0, 0.3333, 0.5 } },
    { text = '(cl) center lower',    urect = { 0.3333, 0.5, 0.3333, 0.5 } },

    { text = '(ru) right upper',    urect = { 0.6666, 0, 0.3333, 0.5 } },
    { text = '(rl) right lower',    urect = { 0.6666, 0.5, 0.3333, 0.5 } },

    { text = '(lh) left half',      urect = { 0, 0, 0.5, 1 } },
    { text = '(rh) right half',     urect = { 0.5, 0, 0.5, 1 } },

    { text = '(lt) left third',    urect = { 0, 0, 0.3333, 1 } },
    { text = '(ct) center third',   urect = { 0, 0.3333, 0.3333, 1 } },
    { text = '(rt) right third',     urect = { 0, 0.6666, 0.3333,1} }

}

local function getSpecForAspect()
    local frame = hs.window.focusedWindow():screen():frame()
    local aspectRatio = frame.w / frame.h
    if aspectRatio >= 2.333333 then
        return _2xApect
    else
        return normalAspect
    end
end

local function getLastFocusedWindow()
    local wf = hs.window.filter
    print('before sort')
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    print('after sort')
    if #lastFocused > 0 then
        return lastFocused[1]
    end
end

local chooser = hs.chooser.new(function (choice)
    if choice then
        print('Made choice')
        local window = getLastFocusedWindow()
        window:move(choice['urect'])
    end
end):width(14):placeholderText('Tile')

hs.hotkey.bind(mod, 'w', function ()
    local choices = getSpecForAspect()
    chooser:choices(choices)
    chooser:show()
end)

return obj
