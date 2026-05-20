-- =============================================================
-- hyprland.lua — migrated from hyprland.conf (hyprlang → Lua)
-- Hyprland 0.55+   https://wiki.hypr.land/Configuring/Start/
-- =============================================================
-- Split large configs with require():
--   require("binds")
--   require("window_rules")
-- Each require() is an isolated scope — errors in one won't
-- break the rest of the config.
-- =============================================================

--------------------
---- MONITORS   ----
--------------------

hl.monitor({
    output   = "",          -- "" = all connected outputs
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

--------------------
---- PROGRAMS   ----
--------------------

local terminal = "alacritty"
local menu     = "rofi -show drun"
local browser  = "brave"

-- Modifier key
local mainMod = "SUPER"

--------------------
---- AUTOSTART  ----
--------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -i /usr/share/backgrounds/wallpaper.jpg")
    -- Optional: notification daemon
    -- hl.exec_cmd("dunst")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE",    "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in    = 6,
        gaps_out   = 12,
        border_size = 2,

        col = {
            -- Purple active border (matches your original cba6f7)
            active_border   = "rgba(cba6f7ff)",
            inactive_border = "rgba(585b70aa)",
        },

        -- NEW: lets you resize by dragging borders/gaps — no extra keybind needed
        resize_on_border = true,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,  -- NEW: controls corner curve shape (2 = circular)

        active_opacity   = 1.0,
        inactive_opacity = 0.93,  -- Subtle transparency on unfocused windows

        shadow = {
            enabled      = true,
            range        = 8,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 6,
            passes    = 2,
            vibrancy  = 0.17,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,   -- keeps your split direction when rearranging
        smart_split    = true,   -- NEW: split towards the cursor position
        smart_resizing = true,   -- NEW: resize proportionally on both sides
    },

    misc = {
        force_default_wallpaper = 0,   -- disables anime mascot splash
        disable_hyprland_logo   = true,
    },
})

-- Animation curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global",          enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "windows",         enabled = true, speed = 4.8,  bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",       enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",      enabled = true, speed = 1.5,  bezier = "almostLinear", style = "popin 87%" })
hl.animation({ leaf = "fade",            enabled = true, speed = 3.0,  bezier = "quick" })
hl.animation({ leaf = "workspaces",      enabled = true, speed = 5,    bezier = "easeOutQuint", style = "slidevert" })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us,no",
        kb_options = "grp:alt_shift_toggle",

        follow_mouse = 1,
        sensitivity  = 0,  -- 0 = no acceleration change

        touchpad = {
            natural_scroll    = true,
            tap_to_click      = true,   -- NEW: tap to click on touchpad
            drag_lock         = true,   -- NEW: helps with drag-and-drop
        },
    },
})

-- NEW: 3-finger horizontal swipe to switch workspaces
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

---------------------
---- KEYBINDINGS ----
---------------------

-- Launch apps
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(browser))

-- Window management
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))

-- Reload / exit
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())

-- Lock screen
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("swaylock -c 000000"))

-- Screenshot
hl.bind("Print",                 hl.dsp.exec_cmd("grim"))
hl.bind(mainMod .. " + Print",   hl.dsp.exec_cmd("grim -g \"$(slurp)\""))  -- NEW: region screenshot

-- Focus movement (HJKL)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows (HJKL)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- NEW: Mouse drag to move and resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })  -- LMB drag = move
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })  -- RMB drag = resize

-- Workspaces 1–9 (loop)
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,   hl.dsp.window.move({ workspace = i }))
end

-- Scroll through workspaces with mouse wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Hardware / media keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pamixer -i 5"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pamixer -d 5"),  { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pamixer -t"),    { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })

------------------------------------
---- WINDOW PRESETS (NEW!)       ----
-- Super+P opens a preset picker --
------------------------------------

-- Helper: apply a named floating preset to the active window
local function float_preset(x_pct, y_pct, w_pct, h_pct)
    return function()
        local w = hl.get_active_window()
        if w == nil then return end
        hl.dispatch(hl.dsp.window.float({ action = "set" }))
        hl.dispatch(hl.dsp.window.resize({ exact = true,
            width  = math.floor(hl.get_monitor().width  * w_pct),
            height = math.floor(hl.get_monitor().height * h_pct),
        }))
        hl.dispatch(hl.dsp.window.move({ position = {
            x = math.floor(hl.get_monitor().width  * x_pct),
            y = math.floor(hl.get_monitor().height * y_pct),
        }}))
    end
end

-- Preset keybinds under SUPER + P + <key>
-- Left half
hl.bind(mainMod .. " + P + H", float_preset(0,    0.05, 0.5,  0.9))
-- Right half
hl.bind(mainMod .. " + P + L", float_preset(0.5,  0.05, 0.5,  0.9))
-- Top half
hl.bind(mainMod .. " + P + K", float_preset(0,    0,    1.0,  0.5))
-- Bottom half
hl.bind(mainMod .. " + P + J", float_preset(0,    0.5,  1.0,  0.5))
-- Center large (75%)
hl.bind(mainMod .. " + P + C", float_preset(0.125, 0.05, 0.75, 0.9))
-- Small centered (40%)
hl.bind(mainMod .. " + P + S", float_preset(0.3,  0.1,  0.4,  0.8))

-- SUPER + P + T: toggle between tiling and floating
hl.bind(mainMod .. " + P + T", hl.dsp.window.float({ action = "toggle" }))

------------------------------------
---- WINDOW RULES               ----
------------------------------------

-- Suppress maximize events from all apps
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
-- Fix XWayland drag issues
hl.window_rule({ name = "fix-xwayland-drags", match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true })
-- Assign different apps to workspaces
-- 2
hl.window_rule({ workspace = 2, match = { class = "^Brave-browser$" } })
-- 5
hl.window_rule({ workspace = 5, match = { class = "^signal$" } })
hl.window_rule({ workspace = 5, match = { class = "^discord$" } })
-- 6
hl.window_rule({ workspace = 6, match = { class = "^Spotify$" } })
-- 9
hl.window_rule({ workspace = 9, match = { class = "^faugus-launcher$" }, float = true  })
hl.window_rule({ workspace = 9, match = { initial_title = "^Battle.net$" }, float = true  })
hl.window_rule({ workspace = 9, match = { initial_title = "^World of Warcraft$" }, fullscreen = true })
