-- Lazy
return{
    "vague2k/huez.nvim",
    -- if you want registry related features, uncomment this
    import = "huez-manager.import",
    branch = "stable",
    event = "UIEnter",
    config = function()
        require("huez").setup({})
    end,
}
