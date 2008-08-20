-- GGLucas' Awesome-3 Lua Config :D
-- Version 2
------
-- If you have any suggestions or questions, feel free
-- to pass me a message, find me in #awesome on OFTC, or
-- email me at <lucasdevries[at]gmail.com>
------
-- I use both wicked and eminent, so to use it,
-- you'll need to get both those helper libraries too.
------
-- Note that I use all-custom keybindings, so you might
-- want to copy the default rc.lua's keybindings 
-- into here if you wish to use those, although you might
-- find you like mine better :P
------

---- {{{ Require lua libraries
-- Shipped with awesome
require("awful")
require("beautiful")

-- External
require("wicked") -- Widgets
require("eminent") -- Dynamic tagging
-- }}}

---- {{{ 'Beautiful' theme settings
-- Font
beautiful.font = "Terminus 8"

-- Background
beautiful.bg_normal = '#22222222'
beautiful.bg_focus = '#285577'
beautiful.bg_sbfocus = '#11335565'
beautiful.bg_urgent = '#A10000'

-- Foreground
beautiful.fg_normal = '#999999'
beautiful.fg_focus = '#ffffff'
beautiful.fg_urgent = '#ffffff'

-- Border
beautiful.border_width = 2
beautiful.border_normal = '#333333'
beautiful.border_focus = '#4C7899'
beautiful.border_marked = '#91231c'

-- }}}

---- {{{ Modkeys
key = {}
key.none = {}
key.alt = {"Mod1"}
key.super = {"Mod4"}
key.shift = {"Shift"}
key.control = {"Control"}

key.super_alt = {key.super[1], key.alt[1]}
key.super_shift = {key.super[1], key.shift[1]}
key.super_control = {key.super[1], key.control[1]}
key.control_alt = {key.control[1], key.alt[1]}
key.shift_alt = {key.shift[1], key.alt[1]}

-- }}}

---- {{{ Settings
-- Initialise tables
settings = {}
settings.widget = {}
settings.apps = {}
settings.tag = {}
settings.bindings = {}

-- {{{ General
-- Widget spacer and separator
settings.widget_spacer = " "
settings.widget_separator = " "

-- Warp mouse
settings.warp_mouse = true

-- New become master
settings.new_become_master = false

-- Tag mwfact
settings.tag.mwfact = 0.618033988769

-- }}}

-- {{{ Applications
-- Terminal application
settings.apps.terminal = 'urxvtc'

-- Terminal with gnu screen
settings.apps.gnu_screen = settings.apps.terminal..' -e zsh -c "exec screen -x main"'

-- Terminal with gnu screen over ssh to my main machine
settings.apps.gnu_screen_ssh_desktop = settings.apps.terminal..' -e zsh -c "ssh -t me.glacicle.com screen -x main"'

-- Terminal with gnu screen over ssh to my vps server
settings.apps.gnu_screen_ssh_server = settings.apps.terminal..' -e zsh -c "ssh -t glacicle.com screen -x"'

-- Command to lock the screen
settings.apps.lock_screen = 'xscreensaver-command -lock'

-- Command to turn screen off with DPMS
settings.apps.screen_off = 'sleep 1; xset dpms force off'

-- File manager application
settings.apps.filemanager = settings.apps.terminal..' -e zsh -c "vifm %s"'

-- Toggle music
-- Note: mpdtoggle is my own script for finding out if 
-- I want to toggle or play/stop, replace it with mpc if
-- you wish to use it.
settings.apps.music_toggle = "mpdtoggle toggle"

-- }}}

-- {{{ Floating windows
settings.floating = {
    ["gimp"] = true,
    ["urxvtcnotify"] = true,
}

-- }}}

-- {{{ Other
-- Check what widget mode to use
if io.open(os.getenv("HOME").."/.laptop_mode") then
    -- Special file exists, display widgets I want
    -- on my laptop
    settings.widget_mode = 'laptop'
else 
    settings.widget_mode = 'desktop'
end

-- Highlight statusbar of focussed screen on multiple-monitor setups
if screen.count() > 1 then
    settings.statusbar_highlight_focus = {true, 1}
end

-- }}}

-- }}}

---- {{{ Keybindings
-- Initialise table
settings.bindings.wm = {}
settings.bindings.mouse = {}

-- {{{ Open the filemanager at specific locations
settings.bindings.filemanager = {
    -- Data partition
    ["/data"] = {key.alt, "d"},

    -- Home Directory
    [os.getenv("HOME")] = {key.alt, "a"},
}
-- }}}

-- {{{ Run specific commands
settings.bindings.commands = {
    -- Open Terminal
    [settings.apps.terminal] = {key.alt, "q"},

    -- GNU Screen
    [settings.apps.gnu_screen] = {key.super, "k"},

    -- GNU Screen over SSH to Desktop
    [settings.apps.gnu_screen_ssh_desktop] = {key.super_shift, "k"},

    -- GNU Screen over SSH to VPS
    [settings.apps.gnu_screen_ssh_server] = {key.super_alt, "k"},

    -- Lock screen
    [settings.apps.lock_screen] = {key.super, "l"},

    -- Screen off with DPMS
    [settings.apps.screen_off] = {key.super, "o"},

    -- Toggle music
    [settings.apps.music_toggle] = {key.alt, "e"},
}
-- }}}

-- {{{ Client keybindings
settings.bindings.wm.client = {
    -- Alt+`: Close window
    [function() client.focus:kill() end] = {key.alt, "#49"},

    -- Mod+q: Focus previous window
    [function() awful.client.focusbyidx(-1) end] = {key.super, "q"},

    -- Mod+w: Focus next window
    [function() awful.client.focusbyidx(1) end] = {key.super, "w"},

    -- Mod+Shift+q: Swap with previous window
    [function() awful.client.swap(-1) end] = {key.super_shift, "q"},

    -- Mod+Shift+w: Swap with previous window
    [function() awful.client.swap(1) end] = {key.super_shift, "w"},

    -- Mod+c: Toggle floating
    [awful.client.togglefloating] = {key.super, "c"},

    -- Mod+\: Make window master
    [function() local c = awful.client.master(); if c ~= client.focus then c:swap(client.focus) end end] =
        {key.super, "#51"},

    -- Mod+Shift+a: Move window to previous tag
    [function () awful.client.movetotag(eminent.tag.getprev(mouse.screen)) end] =
        {key.super_shift, "a"},

    -- Mod+Shift+s: Move window to next tag
    [function () awful.client.movetotag(eminent.tag.getnext(mouse.screen)) end] =
        {key.super_shift, "s"},

    -- Mod+Shift+e: Move window to next screen
    [function () s = client.focus.screen+1; if s > screen.count() then s = 1 end; client.focus.screen = s end] =
        {key.super_shift, "e"},

    -- Mod+Shift+d: Move window to previous screen
    [function () s = client.focus.screen-1; if s < 1 then s = screen.count() end; client.focus.screen = s end] =
        {key.super_shift, "d"},
}
-- }}}

-- {{{ Tag bindings
settings.bindings.wm.tag = {
    -- Mod+a: Switch to previous tag
    [function() eminent.tag.prev(mouse.screen) end] = {key.super, "a"},

    -- Mod+s: Switch to next tag
    [function() eminent.tag.next(mouse.screen) end] = {key.super, "s"},

    -- Alt+\: Switch to float layout
    [function() awful.layout.set('floating') end] = {key.alt, "#51"},

    -- Alt+z: Switch to max layout
    [function() awful.layout.set('max') end] = {key.alt, "z"},

    -- Alt+x: Switch to tile layout
    [function() awful.layout.set('tile') end] = {key.alt, "x"},
}
-- }}}

-- {{{ Prompt bindings
settings.bindings.prompt = {
    -- Alt+w: Run prompt
    [{awful.spawn, " Run: "}] = {key.alt, "w"},

    -- Mod+Alt+w: Lua eval prompt
    [{awful.eval, " Run Lua: "}] = {key.super_alt, "w"},
}

-- }}}

-- {{{ Miscellaneous bindings
settings.bindings.wm.misc = {
    -- Mod+Alt+r: Restart awesome
    [awesome.restart] = {key.super_alt, "r"},

    -- Mod+e: Switch focus to next screen
    [function() awful.screen.focus(1) end] = {key.super, "e"},

    -- Mod+d: Switch focus to previous screen
    [function() awful.screen.focus(-1) end] = {key.super, "d"},
}
-- }}}

-- {{{ Keyboard digit bindings
settings.bindings.digits = {
    -- Mod+##: View tag
    [awful.tag.viewonly] = key.super,

    -- Mod+Shift+##: Toggle tag view
    [function(t) t.selected = not t.selected end] = key.super_shift,

    -- Mod+Control+##: Move window to tag
    [awful.client.movetotag] = key.super_control,

    -- Mod+Alt+##: Toggle window on tag
    [awful.client.toggletag] = key.super_alt,

}
-- }}}

-- {{{ Mouse bindings
settings.bindings.mouse.desktop = {
    -- Right click on desktop: Open terminal
    [function() awful.spawn(settings.apps.terminal) end] = {key.none, 3},
}

settings.bindings.mouse.client = {
    -- Alt+Left: Move window
    [function(c) c:mouse_move() end] = {key.alt, 1},

    -- Alt+Right: Resize window
    [function(c) c:mouse_resize({corner="bottomright"}) end] = {key.alt, 3},
}
-- }}}

-- }}}

---- {{{ Markup helper functions
-- Inline markup is a tad ugly, so use these functions
-- to dynamically create markup, we hook them into
-- the beautiful namespace for clarity.
beautiful.markup = {}

function beautiful.markup.bg(color, text)
    return '<bg color="'..color..'" />'..text
end

function beautiful.markup.fg(color, text)
    return '<span color="'..color..'">'..text..'</span>'
end

function beautiful.markup.font(font, text)
    return '<span font_desc="'..font..'">'..text..'</span>'
end

function beautiful.markup.title(t)
    return t
end

function beautiful.markup.title_normal(t)
    return beautiful.title(t)
end

function beautiful.markup.title_focus(t)
    return beautiful.markup.bg(beautiful.bg_focus, beautiful.markup.fg(beautiful.fg_focus, beautiful.markup.title(t)))
end

function beautiful.markup.title_urgent(t)
    return beautiful.markup.bg(beautiful.bg_urgent, beautiful.markup.fg(beautiful.fg_urgent, beautiful.markup.title(t)))
end

function beautiful.markup.bold(text)
    return '<b>'..text..'</b>'
end

function beautiful.markup.heading(text)
    return beautiful.markup.fg(beautiful.fg_focus, beautiful.markup.bold(text))
end

-- }}}

---- {{{ Widgets
settings.statusbars = {}
settings.widgets = {}

settings.statusbars[1] = {{
    position = "top",
    height = 18,
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal,
    name = "mainstatusbar",
}, "all"}

settings.promptbar = {
    position = "top",
    height = 18,
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal,
    name = "promptbar",
}

-- {{{ Taglist
maintaglist = widget({ type = 'taglist', name = 'maintaglist' })
maintaglist:mouse_add(mouse(key.none, 1, function (o, t) awful.tag.viewonly(t) end))
table.insert(settings.widgets, {1, maintaglist})

function maintaglist.label(t)
    return awful.widget.taglist.label.noempty(t)
end
-- }}}

if settings.widget_mode == 'laptop' or settings.widget_mode == 'all' then
-- {{{ Battery Widget
batterywidget = widget({
    type = 'textbox',
    name = 'batterywidget',
    align = 'right'
})

batterywidget.text = settings.widget_spacer..beautiful.markup.heading('Battery')..': n/a'..settings.widget_spacer..settings.widget_separator
wicked.register(batterywidget, 'function', function (widget, args)
    -- Read temp file created by battery script
    local f = io.open('/tmp/battery-temp')
    if f == nil then
        return settings.widget_spacer..beautiful.markup.heading('Battery')..': n/a'..settings.widget_spacer..settings.widget_separator
    end

    local n = f:read()

    if n == nil then
        f:close()
        return settings.widget_spacer..beautiful.markup.heading('Battery')..': n/a'..settings.widget_spacer..settings.widget_separator
    end

    out = ''
    f:close()

    if n ~= nil then
        out = settings.widget_spacer..beautiful.markup.heading('Battery')..': '..n..settings.widget_spacer..settings.widget_separator
    end
    return out
end, 30)

-- Start timer to read the temp file
awful.hooks.timer.register(28, function ()
    -- Call battery script to get batt%
    command = "battery"
    os.execute(command..' > /tmp/battery-temp &')
end, true)

table.insert(settings.widgets, {1, batterywidget})

-- }}}
end

if settings.widget_mode ~= 'none' then
-- {{{ MPD Widget
mpdwidget = widget({
    type = 'textbox',
    name = 'mpdwidget',
    align = 'right'
})

mpdwidget.text = settings.widget_spacer..beautiful.markup.heading('MPD')..': '..settings.widget_spacer..settings.widget_separator
wicked.register(mpdwidget, 'mpd', function (widget, args)
    -- I don't want the stream name on my statusbar, so I gsub it out,
    -- feel free to remove this bit
    return settings.widget_spacer..beautiful.markup.heading('MPD')..': '
    ..args[1]:gsub('AnimeNfo Radio  | Serving you the best Anime music!: ','')
    ..settings.widget_spacer..settings.widget_separator end)

table.insert(settings.widgets, {1, mpdwidget})

-- }}}

-- {{{ GMail Widget
gmailwidget = widget({
    type = 'textbox',
    name = 'gmailwidget',
    align = 'right'
})

gmailwidget.text =  settings.widget_spacer..beautiful.markup.heading('GMail')..': 0'..settings.widget_spacer..settings.widget_separator
gmailwidget:mouse_add(mouse(key.none, 1, function () wicked.update(gmailwidget) end))

wicked.register(gmailwidget, 'function', function (widget, args)
    -- Read temp file created by gmail check script
    local f = io.open('/tmp/gmail-temp')
    if f == nil then
        return settings.widget_spacer..beautiful.markup.heading('GMail')..': 0'..settings.widget_spacer..settings.widget_separator
    end

    local n = f:read()

    if n == nil then
        f:close()
        return settings.widget_spacer..beautiful.markup.heading('GMail')..': 0'..settings.widget_spacer..settings.widget_separator
    end

    f:close()
    out = settings.widget_spacer..beautiful.markup.heading('GMail')..': '

    if tonumber(n) > 0 then
        out = out..beautiful.markup.bg(beautiful.bg_urgent, beautiful.markup.fg(beautiful.fg_urgent, tostring(n)))
    else
        out = out .. tostring(n)
    end

    out = out..settings.widget_spacer..settings.widget_separator

    return out
end, 120)

-- Start timer to read the temp file
awful.hooks.timer.register(110, function ()
    -- Call GMail check script to check for new email
    os.execute('/home/archlucas/other/.gmail.py > /tmp/gmail-temp &')
end, true)

table.insert(settings.widgets, {1, gmailwidget})

-- }}}

-- {{{ Load Averages Widget
loadwidget = widget({
    type = 'textbox',
    name = 'loadwidget',
    align = 'right'
})

wicked.register(loadwidget, 'function', function (widget, args)
    -- Use /proc/loadavg to get the average system load on 1, 5 and 15 minute intervals
    local f = io.open('/proc/loadavg')
    local n = f:read()
    f:close()

    -- Find the third space
    local pos = n:find(' ', n:find(' ', n:find(' ')+1)+1)

    return settings.widget_spacer..beautiful.markup.heading('Load')..': '..n:sub(1,pos-1)..settings.widget_spacer..settings.widget_separator 

end, 2)

table.insert(settings.widgets, {1, loadwidget})

-- }}}

-- {{{ CPU Usage Widget
cputextwidget = widget({
    type = 'textbox',
    name = 'cputextwidget',
    align = 'right'
})

cputextwidget.text = settings.widget_spacer..beautiful.markup.heading('CPU')..': '..settings.widget_spacer..settings.widget_separator
wicked.register(cputextwidget, 'cpu', function (widget, args) 
    -- Add a zero if lower than 10
    if args[1] < 10 then 
        args[1] = '0'..args[1]
    end

    return settings.widget_spacer..beautiful.markup.heading('CPU')..': '..args[1]..'%'..settings.widget_spacer..settings.widget_separator end) 

table.insert(settings.widgets, {1, cputextwidget})

-- }}}

-- {{{ CPU Graph Widget
cpugraphwidget = widget({
    type = 'graph',
    name = 'cpugraphwidget',
    align = 'right'
})


cpugraphwidget.height = 0.85
cpugraphwidget.width = 45
cpugraphwidget.bg = '#333333'
cpugraphwidget.border_color = '#0a0a0a'
cpugraphwidget.grow = 'left'


cpugraphwidget:plot_properties_set('cpu', {
    fg = '#AEC6D8',
    fg_center = '#285577',
    fg_end = '#285577',
    vertical_gradient = false
})

wicked.register(cpugraphwidget, 'cpu', '$1', 1, 'cpu')
table.insert(settings.widgets, {1, cpugraphwidget})

-- }}}

-- {{{ Memory Usage Widget
memtextwidget = widget({
    type = 'textbox',
    name = 'memtextwidget',
    align = 'right'
})

memtextwidget.text = settings.widget_spacer..beautiful.markup.heading('MEM')..': '..settings.widget_spacer..settings.widget_separator
wicked.register(memtextwidget, 'mem', function (widget, args) 
    -- Add extra preceding zeroes when needed
    if tonumber(args[1]) < 10 then args[1] = '0'..args[1] end
    if tonumber(args[2]) < 1000 then args[2] = '0'..args[2] end
    if tonumber(args[3]) < 1000 then args[3] = '0'..args[3] end
    return settings.widget_spacer..beautiful.markup.heading('MEM')..': '..args[1]..'% ('..args[2]..'/'..args[3]..')'..settings.widget_spacer..settings.widget_separator end)

table.insert(settings.widgets, {1, memtextwidget})

-- }}}

-- {{{ Memory Graph Widget
memgraphwidget = widget({
    type = 'graph',
    name = 'memgraphwidget',
    align = 'right'
})

memgraphwidget.height = 0.85
memgraphwidget.width = 45
memgraphwidget.bg = '#333333'
memgraphwidget.border_color = '#0a0a0a'
memgraphwidget.grow = 'left'

memgraphwidget:plot_properties_set('mem', {
    fg = '#AEC6D8',
    fg_center = '#285577',
    fg_end = '#285577',
    vertical_gradient = false
})

wicked.register(memgraphwidget, 'mem', '$1', 1, 'mem')
table.insert(settings.widgets, {1, memgraphwidget})

-- }}}

-- {{{ Other Widget
settings.widget_spacerwidget = widget({ type = 'textbox', name = 'settings.widget_spacerwidget', align = 'right' })
settings.widget_spacerwidget.text = settings.widget_spacer..settings.widget_separator
table.insert(settings.widgets, {1, settings.widget_spacerwidget})

-- }}}
end

-- }}}

-------------------------------------------------------
-- You shouldn't have to edit the code after this, 
-- it takes care of applying the settings above.
-------------------------------------------------------

---- {{{ Initialisations
-- Register beautiful with awful
awful.beautiful.register(beautiful)

-- Set default colors
awesome.colors_set({ 
    fg = beautiful.fg_normal, 
    bg = beautiful.bg_normal })

-- Set default font
awesome.font_set(beautiful.font)

-- Pre-create new tags with eminent
for s=1, screen.count() do
    eminent.newtag(s, 5)
end

-- }}}

---- {{{ Create statusbars
local mainstatusbar = {}

for i, b in pairs(settings.statusbars) do
    mainstatusbar[i] = {}

    for s=1,screen.count() do
        this_screen = false

        if b[2] ~= "all" then
            for sc in pairs(b[2]) do
                if sc == s then
                    this_screen = true
                    break
                end
            end
        end

        if b[2] == "all" or this_screen then
            mainstatusbar[i][s] = statusbar(b[1])
            local widgets = {}

            for ii, w in pairs(settings.widgets) do
                if w[1] == i then
                    table.insert(widgets, w[2])
                end
            end

            mainstatusbar[i][s]:widgets(widgets)
            mainstatusbar[i][s].screen = s
        end
    end
end

-- }}}

---- {{{ Create prompt statusbar
local mainpromptbar = statusbar(settings.promptbar)
local mainpromptbox = widget({type = "textbox", align = "left", name = "mainpromptbox"})

mainpromptbar:widgets({mainpromptbox})
mainpromptbar.screen = nil

-- }}}

---- {{{ Useful functions
-- {{{ Mouse warp function
function mouse_warp(c, force)
    -- Allow skipping a warp
    if warp_skip then
        warp_skip = false
        return
    end

    -- Get vars
    local sel = c or client.focus
    if sel == nil then return end

    local coords = sel:coords()
    local m = mouse.coords()

    -- Settings
    mouse_padd = 6
    border_area = 5
    
    -- Check if mouse is not already inside the window
    if  (( m.x < coords.x-border_area or
           m.y < coords.y-border_area or
           m.x > coords.x+coords.width+border_area or
           m.y > coords.y+coords.height+border_area
        ) and (
           table.maxn(m.buttons) == 0
        )) or force
    then
        mouse.coords({ x=coords.x+mouse_padd, y=coords.y+mouse_padd})
    end
end
-- }}}

-- {{{ Prompt with statusbar
function prompt_statusbar(s, callback, prompt)
    if not callback then callback = awful.spawn end
    if not prompt then prompt = " Run: " end

    for i, b in pairs(mainstatusbar) do
        for ii, bb in pairs(b) do
            if bb.screen == s then
                bb.screen = nil
            end
        end 
    end

    mainpromptbar.screen = s

    awful.prompt.run({prompt = prompt}, mainpromptbox, callback, 
        awful.completion.bash, os.getenv("HOME") .. "/.cache/awesome_history", 50, function ()
            mainpromptbar.screen = nil

            for i, b in pairs(mainstatusbar) do
                for ii, bb in pairs(b) do
                    if ii == s then
                        bb.screen = ii
                    end
                end 
            end
        end)
end

-- }}}

-- }}}

---- {{{ Create bindings
--- This reads the binding tables and turns them into actual keybindings

-- WM Bindings
for i,table in pairs(settings.bindings.wm) do
    for f, keys in pairs(table) do
        keybinding(keys[1], keys[2], f):add()
    end
end

-- Keyboard digit bindings
for i=1,9 do
    for f, mod in pairs(settings.bindings.digits) do
        keybinding(mod, i, function()
            t = eminent.tag.getn(i, nil, true)
            if not t then return end
            f(t)
        end):add()
    end
end

-- Prompt Bindings
for prompt, keys in pairs(settings.bindings.prompt) do
    keybinding(keys[1], keys[2], function() prompt_statusbar(mouse.screen, unpack(prompt)) end):add()
end

-- Filemanager bindings
for loc, keys in pairs(settings.bindings.filemanager) do
    keybinding(keys[1], keys[2], function() awful.spawn(string.format(settings.apps.filemanager, loc)) end):add()
end

-- Custom command bindings
for command, keys in pairs(settings.bindings.commands) do
    keybinding(keys[1], keys[2], function() awful.spawn(command) end):add()
end

-- Desktop mouse bindings
for f, keys in pairs(settings.bindings.mouse.desktop) do
    awesome.mouse_add(mouse(keys[1], keys[2], f))
end

-- }}}

---- {{{ Set hooks

-- {{{ Focus hook
awful.hooks.focus.register(function (c)

    -- Skip over my urxvtcnotify
    if c.name:lower():find('urxvtcnotify') and awful.client.next(1) ~= c then
        awful.client.focusbyidx(1)
        return
    end

    -- Set border
    c.border_color = beautiful.border_focus

    -- Raise the client
    c:raise()

    -- Set statusbar color
    if settings.statusbar_highlight_focus and settings.statusbar_highlight_focus[1] then
        if last_screen == nil or last_screen ~= c.screen then
            mainstatusbar[settings.statusbar_highlight_focus[2]][c.screen].bg = beautiful.bg_sbfocus

            if last_screen then
                mainstatusbar[settings.statusbar_highlight_focus[2]][last_screen].bg = beautiful.bg_normal
            end
        end

        last_screen = c.screen
    end

end)
-- }}}

-- {{{ Unfocus hook
awful.hooks.unfocus.register(function (c)
    -- Set border
    c.border_color = beautiful.border_normal
end)
-- }}}

-- {{{ Mouseover hook
awful.hooks.mouseover.register(function (c)
    -- Set focus for sloppy focus
    client.focus = c
end)
-- }}}

-- {{{ Manage hook
awful.hooks.manage.register(function (c)
    local class = c.class:lower()
    local name = c.name:lower()

    -- Create border
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal

    -- Smart floating placement
    c.floating_placement = "smart"

    -- Add mouse bindings
    for f, keys in pairs(settings.bindings.mouse.client) do
        c:mouse_add(mouse(keys[1], keys[2], f))
    end

    -- Check if floating
    for app, i in pairs(settings.floating) do
        if class:find(app) or name:find(app) then
            c.floating = i
            break
        end
    end

    if name:find('urxvtcnotify') then
        -- I got sick of libnotify/notification-daemon
        -- and their dependencies, so I'm using a little
        -- urxvtc window with some text in it as notifications :P
        -- This makes it appear at the correct place,
        -- feel free to remove the whole section, you probably
        -- won't need it.

        c.screen = 3

        c:coords({
            x = 1680*2+1400,
            y = 18,
            width = 276,
            height = 106
        })

        c.border_color = beautiful.border_normal

        local tags = {}
        for i,t in pairs(eminent.tags[3]) do
            if eminent.tag.isoccupied(3, t) then
                table.insert(tags, t)
            end
        end

        c:tags(tags)

        return 0
    end

    -- Focus new clients
    client.focus = c

    -- Prevent new windows from becoming master
    if not settings.new_become_master then
        awful.client.swap(1, c)
    end

    -- Don't honor size hints
    c.honorsizehints = false
end)
-- }}}

-- {{{ Arrange hook
awful.hooks.arrange.register(function(s)
    -- Warp the mouse
    if settings.warp_mouse then
        mouse_warp()
    end

    -- Check focus
    if not client.focus then
        local c = awful.client.focus.history.get(s, 0)
        if c then client.focus = c end
    end
end)
-- }}}

-- }}}

-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
