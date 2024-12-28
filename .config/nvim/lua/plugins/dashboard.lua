return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			config = {
				header = {
      "  ⠀ ████   ████       ⠀ ████   ████       ⠀ ████   ████    ",
			"  ███   ███   ███     ███   ███   ███ ⠀   ███   ███   ███  ",
			" ██  ███   ███  ██   ██  ███   ███  ██   ██  ███   ███  ██ ",
			" ⠀ ███⠀ ⠀ ⠀⠀ ███⠀⠀   ⠀ ███⠀ ⠀ ⠀⠀ ███⠀⠀⠀  ⠀ ███⠀ ⠀ ⠀⠀ ███⠀ ⠀",
			" ██  ███   ███  ██   ██  ███   ███  ██   ██  ███   ███  ██ ",
			"  ███   ███   ███     ███   ███   ███ ⠀   ███   ███   ███  ",
			"  ⠀ ████   ████       ⠀ ████   ████   ⠀   ⠀ ████   ████    ",
			"",
			"",				},
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
