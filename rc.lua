-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("vicious")
require("eminent")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
--beautiful.init("/home/exo/.config/awesome/exo/theme.lua")
beautiful.init("/home/exo/.config/awesome/exo/theme.lua")


-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}



-- {{{ Menu

--mymainmenu = awful.menu({ items = { { "config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
--                                    { "restart", awesome.restart },
--                                    { "quit", awesome.guit }
--                                  }
--                                                                                                                                            })
-- }}} Menu




-- remind

iinfo= widget({ type="imagebox" })
iinfo.image = image("/home/exo/.config/awesome/icn/info.png")

local function script_output()
    local f = io.popen("/home/exo/scripts/awesome/remind.sh")
            local out = f:read("*a")
                        f:close()
                   return { out }
                         end
                           remwidget = widget({ type = "textbox"})
                  vicious.register(remwidget, script_output, "<span color='#bfbdc0' font='Terminus 10'>$1</span>")
                       remwidget:buttons(awful.util.table.join(                           
                       awful.button({ }, 1, function () awful.util.spawn("urxvt -e emacs -nw /home/exo/scripts/awesome/remind_text", false) end),
                        awful.button({ }, 4, function () awful.util.spawn("urxvt -e vim /home/exo/scripts/awesome/remind_text", false) end),
                     awful.button({ }, 5, function () awful.util.spawn("urxvt -e vim /home/exo/scripts/awesome/remind_text", false) end)
                                         ))



-- thermal
icputemp= widget({ type="imagebox" })
icputemp.image = image("/home/exo/.config/awesome/icn/cputemp.png")

local function script_output()
    local f = io.popen("/home/exo/scripts/awesome/thermal")
            local out = f:read("*a")
                        f:close()
                   return { out }
                         end
                           remwidget2 = widget({ type = "textbox"})
                  vicious.register(remwidget2, script_output, "<span color='#bfbdc0'>$1</span>")
                


-- fanspeed
ifan= widget({ type="imagebox" })
ifan.image = image("/home/exo/.config/awesome/icn/fan.png")

local function script_output()
    local f = io.popen("/home/exo/scripts/awesome/fanspeed")
            local out = f:read("*a")
                        f:close()
                   return { out }
                         end
                           remwidget3 = widget({ type = "textbox"})
                  vicious.register(remwidget3, script_output, "<span color='#bfbdc0'>$1</span>")



-- battery
ipower= widget({ type="imagebox" })
ipower.image = image("/home/exo/.config/awesome/icn/power.png")
local function script_output()
    local f = io.popen("/home/exo/scripts/awesome/battery/bnotify.sh")
            local out = f:read("*a")
                        f:close()
                   return { out }
                         end
                           bnotify = widget({ type = "textbox"})

                  vicious.register(bnotify, script_output, "<span color='#bfbdc0'>$1</span>")







-- weather
iweather = widget({ type="imagebox" })
iweather.image = image("/home/exo/.config/awesome/icn/weather.png")
weatherwidget= widget({ type="textbox",align='left'})
vicious.register(weatherwidget,vicious.widgets.weather,"<span color='#bfbdc0'>${tempc}</span>",1100,"LZPP")

          weatherwidget:buttons(awful.util.table.join(                           
                       awful.button({ }, 1, function () awful.util.spawn("weather", false) end)
                                         ))



-- date info
iclock= widget({ type="imagebox" })
iclock.image = image("/home/exo/.config/awesome/icn/clock.png")

--datewidget = awful.widget.textclock({ align = "right" }, '%a %b %d-%m-%y %H:%M' )
datewidget = awful.widget.textclock({ align = "right" }, "<span color='#bfbdc0'>%d-%m-%y %H:%M</span>" )

-- memory
imem= widget({ type="imagebox" })
imem.image = image("/home/exo/.config/awesome/icn/mem.png")
  memwidget = widget({ type = "textbox" })
  vicious.cache(vicious.widgets.mem)
  vicious.register(memwidget, vicious.widgets.mem, "<span color='#bfbdc0'>$2</span>", 13)


-- volume
ivolume= widget({ type="imagebox" })
ivolume.image = image("/home/exo/.config/awesome/icn/volume.png")
  volume = widget({ type = "textbox" })
  vicious.register(volume, vicious.widgets.volume, "<span color='#bfbdc0'>$1</span>", 1, "Master")



-- Pacman Widget
ipacman= widget({ type="imagebox" })
ipacman.image = image("/home/exo/.config/awesome/icn/pacman.png")
pacman = widget({type="textbox"})
vicious.register(pacman, vicious.widgets.pkg, "$1 ", 300, "Arch")


-- CPU widget
icpu= widget({ type="imagebox" })
icpu.image = image("/home/exo/.config/awesome/icn/cpu.png")
cpuwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "<span color='#bfbdc0'>$1 $2 $3 $4</span>", 10)


ilayout= widget({ type="imagebox" })
ilayout.image = image("/home/exo/.config/awesome/icn/layout.png")


-- Execute command and return its output. You probably won't only execute commands with one
-- line of output
function execute_command(command)
   local fh = io.popen(command)
      local str = ""
         for i in fh:lines() do
                   str = str .. i
                      end
                         io.close(fh)
                            return str
                            end



--fanspeed = widget({ type = "textbox" })
---amytextbox.text = "Hello, world! "
--fanspeed.text = " " .. execute_command("cat /proc/acpi/ibm/fan | grep speed | cut -f 3") .. " "

--thermal = widget({ type = "textbox" })


--thermal.text = " " .. execute_command("cat /proc/acpi/ibm/thermal | cut -c 15-16") .. " "





mytextbox = widget({ type = "textbox" })
mytextbox.text = " "


mytextbox2 = widget({ type = "textbox" })
mytextbox2.text = "\31"

-- 18 25 31



-- {{{ Wibox
-- Create a textclock widget
--mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                   --  awful.button({ }, 3, function ()
                   --                           if instance then
                   --                               instance:hide()
                   --                               instance = nil
                   --                           else
                   --                               instance = awful.menu.clients({ width=250 })
                   --                          end
                   --                       end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do







    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 22 })
    -- Add widgets to the wibox - order matters
   mywibox[s].widgets = {
        {
           -- mylauncher,
            mytaglist[s],
           -- mypromptbox[s],
           -- mytextbox,
           iinfo,
           -- mytextbox,
            mytextbox,
            remwidget,
            mytextbox,
            mytextbox,
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        ilayout,
        mytextbox,
        datewidget,
        iclock,
        mytextbox,
        bnotify,
        ipower,
        mytextbox,
        weatherwidget,
        iweather,
        mytextbox,
        remwidget2,
        icputemp,
        mytextbox,
        remwidget3,
        ifan,
        mytextbox,
        memwidget,
        imem,
        mytextbox,
        cpuwidget,
        icpu,
        mytextbox,
        volume,
        ivolume,
        --mytextbox,
        --pacman,
        --ipacman,
        --mytextbox,
        --s == 1 and mysystray or nil,
        --mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end




-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
 --   awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),

    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
--    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "b",     function () awful.util.spawn("battery_check") end),
    awful.key({ modkey,           }, "u",     function () awful.util.spawn("luakit") end),
    awful.key({ modkey,           }, "i",     function () awful.util.spawn("mail_notify_launcher") end),
    awful.key({ modkey,           }, "p",     function () awful.util.spawn("dmenu_run -i -fn '7x14' -nb '#000000' -nf '#bfbdc0' -sf '#BDE077' -sb '#000000'") end),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
   -- awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)



clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     size_hints_honor = false,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

awful.util.spawn_with_shell("dualscreen.sh")
awful.util.spawn_with_shell("nitrogen --restore")

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)



--- }}}
