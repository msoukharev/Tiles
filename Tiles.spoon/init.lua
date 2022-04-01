local mod = { "cmd", "alt", "ctrl" }

local obj = {}

obj.__index = obj
obj.name = "Tiles"
obj.version = "0.8.2"
obj.author = "Maxim Soukharev"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local function reverse(table)
    local rev = {}
    local j = 0
    for i = #table, 1, -1 do
        j = (j + 1)
        rev[j] = table[i]
    end
    return rev
end

local windowConfigs = {
    normal = {
        upperLeft = { 0, 0, 0.5, 0.5 },
        lowerLeft = { 0, 0.5, 0.5, 0.5 },
        upperRight = { 0.5, 0, 0.5, 0.5 },
        lowerRight = { 0.5, 0.5, 0.5, 0.5 },
        leftHalf = { 0, 0, 0.5, 1 },
        rightHalf = { 0.5, 0, 0.5, 1 },
        leftThird = { 0, 0, 0.3333, 1 },
        centerThird = { 0.3333, 0, 0.3333, 1 },
        rightThird = { 0.6666, 0, 0.3333, 1 },
    },
    _2x = {
        upperLeft = { 0, 0, 0.3333, 0.5 },
        lowerLeft = { 0, 0.5, 0.3333, 0.5 },
        upperCenter = { 0.3333, 0, 0.3333, 0.5 },
        lowerCenter = { 0.3333, 0.5, 0.3333, 0.5 },
        upperRight = { 0.6666, 0, 0.3333, 0.5 },
        lowerRight = { 0.6666, 0.5, 0.3333, 0.5 },
        leftHalf = { 0, 0, 0.5, 1 },
        rightHalf = { 0.5, 0, 0.5, 1 },
        leftThird = { 0, 0, 0.3333, 1 },
        centerThird = { 0.3333, 0, 0.3333, 1 },
        rightThird = { 0.6666, 0, 0.3333,1 }
    }
}

local symbols = {
    normal = {
        upperLeft = '[˚ ]',
        upperRight = '[ ˚]',
        lowerLeft = '[. ]',
        lowerRight = '[ .]',
        leftHalf = '[= ]',
        rightHalf = '[ =]',
        leftThird = '[=  ]',
        centerThird = '[ = ]',
        rightThird = '[  =]'
    },
    _2x = {
        upperLeft = '[˚  ]',
        upperCenter = '[ ˚ ]',
        upperRight = '[  ˚]',
        lowerLeft = '[.  ]',
        lowerCenter = '[ . ]',
        lowerRight = '[  .]',
        leftHalf = '[= ]',
        rightHalf = '[ =]',
        leftThird = '[=  ]',
        centerThird = '[ = ]',
        rightThird = '[  =]'
    }
}

local normalAspect = {
    [1] = {
        {
            text = symbols.normal.upperLeft .. ' upper left',
            urects = { windowConfigs.normal.upperLeft }
        },
        {
            text = symbols.normal.lowerLeft .. ' lower left',
            urects = { windowConfigs.normal.lowerLeft }
        },
        {
            text = symbols.normal.upperRight .. ' right upper',
            urects = { windowConfigs.normal.upperRight }
        },
        {
            text = symbols.normal.lowerRight .. ' lower right',
            urects = { windowConfigs.normal.lowerRight }
        },
        {
            text = symbols.normal.leftHalf .. ' left half',
            urects = { windowConfigs.normal.leftHalf }
        },
        {
            text = symbols.normal.rightHalf .. ' right half',
            urects = { windowConfigs.normal.rightHalf }
        },
        {
            text = symbols.normal.leftThird .. ' left third',
            urects = { windowConfigs.normal.leftThird }
        },
        {
            text = symbols.normal.centerThird .. ' center third',
            urects = { windowConfigs.normal.centerThird }
        },
        {
            text = symbols.normal.rightThird .. ' right third',
            urects = { windowConfigs.normal.rightThird }
        }
    },
    [2] = {
        {
            text = 'left - right half',
            urects = { windowConfigs.normal.leftHalf, windowConfigs.normal.rightHalf }
        },
        {
            text = 'left corners',
            urects = { windowConfigs.normal.upperLeft, windowConfigs.normal.lowerLeft }
        },
        {
            text = 'right corners',
            urects = { windowConfigs.normal.upperRight, windowConfigs.normal.lowerRight }
        },
    }
}

local _2xApect = {
    [1] = {
        {
            text = symbols.normal.upperLeft .. ' upper left',
            urects = { windowConfigs._2x.upperLeft }
        },
        {
            text = symbols._2x.lowerLeft .. ' lower left',
            urects = { windowConfigs._2x.lowerLeft }
        },
        {
            text = symbols._2x.upperCenter .. ' upper center',
            urects = { windowConfigs._2x.upperCenter }
        },
        {
            text = symbols._2x.lowerCenter .. ' lower center',
            urects = { windowConfigs._2x.lowerCenter }
        },
        {
            text = symbols._2x.upperRight .. ' upper right',
            urects = { windowConfigs._2x.upperRight }
        },
        {
            text = symbols._2x.lowerRight .. ' lower right',
            urects = { windowConfigs._2x.lowerRight }
        },
        {
            text = symbols._2x.leftHalf .. ' left half',
            urects = { windowConfigs._2x.leftHalf }
        },
        {
            text = symbols._2x.rightHalf .. ' right half',
            urects = { windowConfigs._2x.rightHalf }
        },
        {
            text = symbols._2x.leftThird .. ' left third',
            urects = { windowConfigs._2x.leftThird }
        },
        {
            text = symbols._2x.centerThird .. ' center third',
            urects = { windowConfigs._2x.centerThird }
        },
        {
            text = symbols._2x.rightThird .. ' right third',
            urects = { windowConfigs._2x.rightThird }
        }
    },
    [2] = {
        {
            text = 'left - right half',
            urects = { windowConfigs._2x.leftHalf, windowConfigs._2x.rightHalf }
        },
        {
            text = 'left corners',
            urects = { windowConfigs._2x.upperLeft, windowConfigs._2x.lowerLeft }
        },
        {
            text = 'right corners',
            urects = { windowConfigs._2x.upperRight, windowConfigs._2x.lowerRight }
        },
    }
}

local function getSpecForAspect(scope)
    scope = scope or 1
    local frame = hs.window.focusedWindow():screen():frame()
    local aspectRatio = frame.w / frame.h
    if aspectRatio >= 2.333333 then
        return _2xApect[scope]
    else
        return normalAspect[scope]
    end
end

local function getLastFocusedWindows(size)
    size = size or 1
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused >= size then
        return reverse( table.pack(table.unpack(lastFocused, 1, size)) )
    end
end

local function getChooser(scope)
    return hs.chooser.new(function (choice)
        if choice then
            local windows = getLastFocusedWindows(scope)
            for i = 1, #windows do
                windows[i]:move(choice.urects[i])
            end
        end
    end):width(14):placeholderText('Tile')
end

hs.hotkey.bind(mod, 'w', function ()
    local choices = getSpecForAspect(1)
    local chooser = getChooser(1)
    chooser:choices(choices)
    chooser:show()
end)

hs.hotkey.bind(mod, 'e', function()
    local choices = getSpecForAspect(2)
    local chooser = getChooser(2)
    chooser:choices(choices)
    chooser:show()
end)

return obj
