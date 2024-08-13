return{
  'wet-sandwich/hyper.nvim', tag = '0.1.3',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function ()
    vim.keymap.set('n', '<leader>hy', require('hyper.view').show, {})
  end
}
