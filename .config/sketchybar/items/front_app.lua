local colors = require("colors")
local settings = require("settings")

-- Events that get pushed by yabai
sbar.add("event", "window_focus")
sbar.add("event", "title_change")

local front_app = sbar.add("item", "front_app", {
  position = "center",
  display = "active",
  icon = {
    background = {
      drawing = true,
      image = {
        border_width = 2,
        border_color = colors.purple,
      }
    },
  },

  label = {
    font = {
      style = settings.font.style_map["Black"],
      size = 12.0,
    },
  },
  updates = true,
})

local function set_window_title()
  -- Offloading the "yabai -m query --windows --window" script to an external shell script so that we can determine whether the space has no windows

  sbar.exec("~/sketchybar/scripts/query_window.sh", function(result)
    if result ~= "empty" and type(result) == "table" and result.title then
      local window_title = result.title
      if #window_title > 50 then
        window_title = window_title:sub(1, 50) .. "..."
      end
      front_app:set({ label = { string = window_title } })
    else
      -- Set title to Finder, as empty spaces will not return a window title
      front_app:set({ label = { string = "Finder" } })
    end
  end)
end

-- Animate app icon back to 1.0
local function end_bounce_animation()
  sbar.animate("tanh", 15, function()
    front_app:set({
      icon = {
        background = {
          image = { scale = 1.0 },
	}
      }
    })
  end)
end

-- Make app icon slightly bigger before returning back to regular size
local function start_bounce_animation()
  sbar.animate("tanh", 15, function()
    front_app:set({
      icon = {
        background = {
          image = { scale = 1.2 },
	}
      }
    })
  end)
  -- Short delay so that full animation can occur
  sbar.exec("sleep 0.25 && echo 'finishing bounce'", end_bounce_animation) 
end

front_app:subscribe("front_app_switched", function(env)
  front_app:set({
    icon = { background = { image = "app." .. env.INFO } },
    label = { string = env.INFO }
  })
  set_window_title()
  start_bounce_animation()
end)

front_app:subscribe("space_change", function()
  set_window_title()
  start_bounce_animation()
end)

front_app:subscribe("window_focus", function()
  set_window_title()
  start_bounce_animation()
end)

front_app:subscribe("title_change", function()
  set_window_title()
end)

front_app:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)