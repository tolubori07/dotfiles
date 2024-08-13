return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
            transparent_background = true,
            show_end_of_buffer = false,
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  }
}
