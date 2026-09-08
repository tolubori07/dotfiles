return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").setup({})
		end,
	},
	{
		"mks-h/treesitter-autoinstall.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("treesitter-autoinstall").setup({
				-- ignore = { "bigfile" }, -- filetypes to skip, if any
				highlight = true, -- auto-enable highlighting on install
			})
		end,
	},
}
