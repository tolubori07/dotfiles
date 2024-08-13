local colors =  {
  black = 0xff221d23,
  white = 0xffcdd6f4,
  red = 0xffcba6f7,
  green = 0xffa6e3a1,
  blue = 0xff556fd7,
  yellow = 0xffa6e3a1,
  orange = 0xfffab387,
  magenta = 0xffcba6f7,
  grey = 0xff939ab7,
  transparent = 0x00000000,
  mauve = 0xffc6a0f7,
  purple = 0xff736fda,
  dark = 0xff051b2c,

  bar = {
    bg = 0xff060010,
    border = 0xff494d64 ,
  },

  popup = {
    bg = 0xff1d1d2b,
    border = 0xffc6a0f7
  },

  bg1 = 0xff485696,
  bg2 = 0xff45475a,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}

colors.bar.bg = colors.with_alpha(colors.bar.bg, 1.0)
colors.bg1 = colors.with_alpha(colors.bg1, 1.0)
colors.bg2 = colors.transparent
return colors
