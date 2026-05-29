hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})

hl.on("hyprland.start", function()
  hl.exec_cmd("sh -c 'nwg-hello; hyprctl dispatch exit'")
end)

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 0,
  },
  decoration = {
    rounding = 0,
    shadow = {
      enabled = false,
    },
    blur = {
      enabled = false,
    },
  },
  animations = {
    enabled = false,
  },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = -1,
  },
  input = {
    kb_layout = "us",
  },
})
