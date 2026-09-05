-- vim: filetype=lua

require("envs")
require("monitors")
require("bindings")
require("autostart")
-- require("theme")

-- NOTE: permissions are ASK by default now (ecosystem.enforce_permissions must
-- be true for config-defined permission rules to actually apply).
hl.config({
    ecosystem = {
        enforce_permissions = true,
    },
})
hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 4,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(e0e0e060)", "rgba(e0e0e060)" }, angle = 90 },
            inactive_border = { colors = { "rgba(00000000)", "rgba(00000000)" }, angle = 90 },
        },
        resize_on_border = true,
        layout = "dwindle",
    },

    cursor = {
        inactive_timeout   = 1,
        enable_hyprcursor  = true,
    },

    decoration = {
        rounding               = 4,
        border_part_of_window  = false,
        active_opacity         = 1,
        inactive_opacity       = 0.8,
        dim_inactive           = true,
        dim_strength           = 0.1,
        dim_special            = 0.3,
        fullscreen_opacity     = 1.0,

        shadow = {
            range = 72,
            color = 0xdd0f0f0f,
        },

        blur = {
            size   = 16,
            passes = 3,
        },
    },
})

hl.curve("OutQuint", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })

hl.animation({ leaf = "global",           enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows",          enabled = true, speed = 5,  bezier = "default" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 4,  bezier = "OutQuint", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,  bezier = "OutQuint", style = "slidevert" })
hl.animation({ leaf = "zoomFactor",       enabled = true, speed = 3,  bezier = "OutQuint" })

hl.config({
    input = {
        -- kb_layout  = "us-german-umlaut",
        -- kb_variant = "nodeadkeys",
        repeat_rate    = 50,
        repeat_delay   = 200,
        follow_mouse   = 1,
        accel_profile  = "adaptive",
        sensitivity    = 0,
    },
})

hl.device({ name = "splitkb.com-kyria-rev2", kb_layout = "us-german-umlaut" })
hl.device({ name = "zmk-project-totem-keyboard", kb_layout = "us-german-umlaut" })
hl.device({ name = "at-translated-set-2-keyboard", kb_layout = "de" })

hl.config({
    dwindle = {
        preserve_split = true,
        -- smart_resizing = false,
        special_scale_factor = 0.9,
    },

    misc = {
        animate_manual_resizes   = true,
        background_color         = "rgba(141414ff)",
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },

    ecosystem = {
        no_update_news = true,
    },

    debug = {
        damage_tracking = 0,
    },
})

for i = 1, 9 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1" })
end
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })

hl.window_rule({
    match = { class = "(blender|brave-browser|chromium|gimp|mpv|org.inkscape.Inkscape|vlc)" },
    tag   = "+visual",
})

hl.window_rule({
    name  = "original",
    match = { tag = "visual" },
    no_dim  = true,
    no_blur = true,
    opacity = "1.0",
    -- rounding = 0,
})
