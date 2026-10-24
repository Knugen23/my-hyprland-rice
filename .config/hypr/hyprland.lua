-- #######################################################################################
-- HYPRLAND LUA CONFIG (Rettet og vasket for v0.57)
-- #######################################################################################

-- Miljøvariabler (Spesielt viktig for Nvidia)
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("cursor:no_hardware_cursors", "true")
hl.env("XCURSOR_SIZE", "12")
hl.env("HYPRCURSOR_SIZE", "12")

-- Hent inn eksterne konfigurasjoner
dofile(os.getenv("HOME") .. "/.config/hypr/monitors.lua")

-- Standardprogrammer og Modifikator
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "hyprlauncher"
local mainMod = "SUPER"

-- #######################################################################################
-- LOOK AND FEEL & SYSTEM CONFIG
-- #######################################################################################

hl.config({
    -- Husk å legge til dine personlige general/decoration tabeller her om du ønsker
    -- f.eks. gaps_in, gaps_out, border_size osv.
    
    -- Rettet Wofi-regler (Flyttet inn i riktig konfigurasjonsblokk)
    windowrulev2 = {
        "float, class:^(wofi)$",
        "pin, class:^(wofi)$",
        "center, class:^(wofi)$"
    }
})

-- Animasjonskurver (Beziers)
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Animasjoner
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Gestures og Enheter
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

-- #######################################################################################
-- KEYBINDINGS (HURTIGTASTER)
-- #######################################################################################

-- Åpne applikasjoner og systemkontroll
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/waybar/scripts/launcher.sh"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Skjermbilde (Grimblast)
hl.bind(mainMod .. " + SHIFT", hl.dsp.exec_cmd("grimblast copy area"))

-- Fokus og flytting av vinduer (Piltaster)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Arbeidsområder (Workspaces 1-6)
for i = 1, 6 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
--hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "1" }))
--hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "2" }))
--hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "3" }))
--hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "4" }))
--hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "5" }))
--hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = "6" }))

-- Spesial-arbeidsområde (Scratchpad / Magic)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Skrolling mellom arbeidsområder
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Hyprshot (Fullført og lukket parantesene som manglet)
hl.bind("F12", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + F12", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("hyprshot -m region"))

-- Lydkontroll (Fullført og lukket parantesene som manglet)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })

-- #######################################################################################
-- MULTIMEDIA- OG VOLUMKNAPPER
-- #######################################################################################
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- #######################################################################################
-- HOVEDKONFIGURASJON (hl.config)
-- #######################################################################################
hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = "rgb(6A5D4C)",
            inactive_border = "rgb(DFCFB5)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    
    animations = {
        enabled = true, -- Endret fra "yes, please :)" til true for å unngå krasj
    },
    
    dwindle = {
        preserve_split = true,
    },
    
    master = {
        new_status = "master",
    },
    
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
    
    input = {
        kb_layout = "no, us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },

    -- Flyttet de tre vindusreglene dine inn hit (Riktig format for v0.57)
    windowrulev2 = {
        "suppressmaximize, class:(.*)",
        "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0",
        "move 20 monitor_h-120, class:(hyprland-run)",
        "float, class:(hyprland-run)"
    }
})

-- #######################################################################################
-- AUTOSTART (Ved oppstart av Hyprland)
-- #######################################################################################
hl.on("hyprland.start", function()
    hl.exec_cmd("tailscale systray")
    hl.exec_cmd("hyperpolkitagent")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("xrandr --output DP-2 --primary") -- Rettet skrivefeil fra --primaryy
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("nm-applet --indicator")
end)
