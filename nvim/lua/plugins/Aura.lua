return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      --vim.cmd([[colorscheme aura-dark]])
    end,
  },
}
