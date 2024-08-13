local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = false,
  height = 40,
  position = "top",
  -- color = colors.with_alpha(colors.bar.bg, 0.5),
  color = colors.with_alpha(colors.bar.bg, 1),
   padding_right = 4,
  padding_left = 4,
  corner_radius = 40,
  margin = 17,
  y_offset = 5,
   border_width = 2,
  border_color = colors.purple
})
