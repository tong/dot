-- vim: filetype=lua

-- env = XCURSOR_SIZE,24
-- env = HYPRCURSOR_SIZE,24
--
-- hl.env("GDK_BACKEND", "wayland,x11,*")
-- hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")
-- hl.env("SDL_VIDEODRIVER", "wayland")
-- hl.env("MOZ_ENABLE_WAYLAND", "1")
-- hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
-- hl.env("OZONE_PLATFORM", "wayland")

hl.env("GTK_THEME", "Adwaita:dark")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
