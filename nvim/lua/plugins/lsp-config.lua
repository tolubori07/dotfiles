return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		-- nvim-lspconfig is now optional — you can remove it
		-- if you're fully on the native API
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				"ts_ls",
				"solargraph",
				"html",
				"lua_ls",
				"emmet_ls",
				"rust_analyzer",
				"astro",
				"jsonls",
				"zls",
				"julials",
				"prismals",
        "pyright"
			}

			-- clangd needs custom cmd, so configure it separately
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
			})

			for _, server in ipairs(servers) do
				vim.lsp.config(server, { capabilities = capabilities })
			end

			vim.lsp.enable(servers)
			vim.lsp.enable("clangd")

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
