-- vim: filetype=lua

local mainMod = "SUPER"

-- local terminal = "uwsm app -- " .. os.getenv("TERMINAL")
local terminal = os.getenv("TERMINAL")
-- local launcher = "hyprlauncher"

local resizeH = 200
local resizeV = 200

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + W", hl.dsp.window.close())

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(os.getenv("BROWSER")))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(os.getenv("FILEMANAGER_GUI")))

-- hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
-- NOTE: `launcher` was never actually defined in the original bindings.conf
-- (only commented out), so this bind was likely silently broken already.
-- Preserved as-is.
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

hl.bind(mainMod .. " + CTRL + ALT + Q", hl.dsp.exit())

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }))

hl.bind(mainMod .. " + CTRL + SHIFT + H", hl.dsp.window.move({ workspace = "e-1", follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.window.move({ workspace = "e+1", follow = true }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -resizeH, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = resizeV, relative = true }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -resizeV, relative = true }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = resizeH, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -resizeH, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = resizeV, relative = true }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -resizeV, relative = true }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = resizeH, y = 0, relative = true }))

hl.bind(mainMod .. " + tab", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + apostrophe", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + escape", hl.dsp.focus({ workspace = "e-1" }))
-- hl.bind(mainMod .. " + backspace", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.window.cycle_next())
-- hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e+1" }))

-- hl.bind(mainMod .. " + semicolon", hl.dsp.workspace.toggle_special(""))
hl.bind(mainMod .. " + i", hl.dsp.workspace.toggle_special(""))
hl.bind(mainMod .. " + SHIFT + i", hl.dsp.window.move({ workspace = "special" }))
-- hl.bind(mainMod .. " + SHIFT + semicolon", hl.dsp.window.move({ workspace = "special" }))

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + semicolon", hl.dsp.window.float())

-- hl.bind(mainMod .. " + s", hl.dsp.exec_cmd("scratchpad")) -- move current window to scratchpad
-- hl.bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd("scratchpad -g")) -- move scratchpad window back to normal
-- hl.bind(mainMod .. " + CTRL + s", hl.dsp.exec_cmd("scratchpad -t"))

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + CTRL + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + 4", hl.dsp.window.move({ workspace = 1, follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = true }))

-- Screenshot submap
-- TODO
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.submap("screenshot"))
-- hl.define_submap("screenshot", function()
--     -- hl.bind("space", hl.dsp.exec_cmd("screenshot a"))
--     -- hl.bind("space", hl.dsp.submap("reset"))
--     hl.bind("a", hl.dsp.exec_cmd("notify-send yyyyess"))
--     hl.bind("r", hl.dsp.exec_cmd("/home/tong/.local/bin/screenshot r"))
--     -- hl.bind("r", hl.dsp.submap("reset"))
--     hl.bind("escape", hl.dsp.submap("reset"))
-- end)

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +3%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -3%"))
hl.bind("CTRL + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("CTRL + XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
-- XF86MonBrightnessUp
-- XF86MonBrightnessDown

-- Mediaplayer submap
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.submap("mediaplayer"))
hl.define_submap("mediaplayer", function()
	hl.bind("j", hl.dsp.exec_cmd("playerctl position 10-"), { repeating = true })
	hl.bind("k", hl.dsp.exec_cmd("playerctl position 10+"), { repeating = true })
	hl.bind("h", hl.dsp.exec_cmd("playerctl next"))
	hl.bind("l", hl.dsp.exec_cmd("playerctl previous"))
	hl.bind("space", hl.dsp.exec_cmd("playerctl play-pause"))
	hl.bind("p", hl.dsp.exec_cmd("playerctl play-pause"))
	-- hl.bind("p", hl.dsp.submap("reset")) -- reset submap on toggle play/pause
	hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- NOTE: best-effort translation of the old `hyprctl keyword cursor:zoom_factor ...`
-- runtime trick. `keyword` no longer exists; `hyprctl getoption` now uses dotted
-- paths (cursor.zoom_factor instead of cursor:zoom_factor), and live config
-- changes go through `hyprctl eval` calling hl.config(). Worth testing.
hl.bind(
	mainMod .. " + CTRL + mouse_down",
	hl.dsp.exec_cmd(
		"hyprctl -q eval \"hl.config({ cursor = { zoom_factor = $(hyprctl getoption cursor.zoom_factor -j | jq '.float * 1.1') } })\""
	)
)
hl.bind(
	mainMod .. " + CTRL + mouse_up",
	hl.dsp.exec_cmd(
		"hyprctl -q eval \"hl.config({ cursor = { zoom_factor = $(hyprctl getoption cursor.zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end') } })\""
	)
)
hl.bind(
	mainMod .. " + CTRL + equal",
	hl.dsp.exec_cmd(
		"hyprctl -q eval \"hl.config({ cursor = { zoom_factor = $(hyprctl getoption cursor.zoom_factor -j | jq '.float * 1.1') } })\""
	),
	{ repeating = true }
)
-- hl.bind(mainMod .. " + KP_ADD", hl.dsp.exec_cmd("hyprctl -q eval \"hl.config({ cursor = { zoom_factor = $(hyprctl getoption cursor.zoom_factor -j | jq '.float * 1.1') } })\""))
-- hl.bind(mainMod .. " + KP_SUBTRACT", hl.dsp.exec_cmd("hyprctl -q eval \"hl.config({ cursor = { zoom_factor = $(hyprctl getoption cursor.zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end') } })\""))
