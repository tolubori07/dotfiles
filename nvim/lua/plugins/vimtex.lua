return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_syntax_enabled = 0
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			callback = 1,
			continuous = 1,
			executable = "latexmk",
			options = {
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}
		-- Do not open pdfviwer on compile
		vim.g.vimtex_view_automatic = 0
	end,
}
