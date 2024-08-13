local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local flow = sbar.add("item", {
  update_freq = 1,
  script = '~/.config/sketchybar/scipts/flow',
  click_script = [[sbar -m --set flow popup.drawing=toggle]],
  popup = {
    background = {
      border_width = 3,
      corner_radius = 4,
      border_color = 0xFFCA9EE6,
      color = 0xFF737994
    },
    horizontal = true,
    align = "center"
  }
})

local flow_start = sbar.add("item", "flow.start", {
  label = "Start",
  click_script = [[osascript -e 'tell application "Flow" to start' ; sbar -m --set flow popup.drawing=toggle]]
})

local flow_stop = sbar.add("item", "flow.stop", {
  label = "Stop",
  click_script = [[osascript -e 'tell application "Flow" to stop' ; sbar -m --set flow popup.drawing=toggle]]
})

local flow_skip = sbar.add("item", "flow.skip", {
  label = "Skip",
  click_script = [[osascript -e 'tell application "Flow" to skip' ; sbar -m --set flow popup.drawing=toggle]]
})

local flow_reset = sbar.add("item", "flow.reset", {
  label = "Reset",
  click_script = [[osascript -e 'tell application "Flow" to reset' ; sbar -m --set flow popup.drawing=toggle]]
})

local flow_show = sbar.add("item", "flow.show", {
  label = "Show",
  click_script = [[osascript -e 'tell application "Flow" to show' ; sbar -m --set flow popup.drawing=toggle]]
})

sbar.add("bracket", { 'flow', 'flow.start', 'flow.stop', 'flow.skip', 'flow.reset', 'flow.show' }, {
  background = { color = colors.bg2 },
  border_color = colors.purple
})



return flow
