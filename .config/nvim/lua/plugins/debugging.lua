return{
"mfussenegger/nvim-dap",
  dependencies ={
'rcarriga/nvim-dap-ui',
'mfussenegger/nvim-dap-python',
'leoluz/nvim-dap-go',
  },
  config = function ()
    local dap = require("dap")
    local dapui = require("dapui")
    require("dap-go").setup()
    require("dap-python").setup()
    require("dapui").setup()
    dap.listeners.before.attach.dapui_config = function()
  dapui.open()
    end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
    end
  dap.listeners.before.event_terminated.dapui_config = function()
   dapui.close()
    end
  dap.listeners.before.event_exited.dapui_config = function()
   dapui.close()
    end
 vim.keymap.set('n', '<Leader>dt',dap.toggle_breakpoint,{})

 vim.keymap.set('n', '<Leader>dc',dap.continue,{})
  end,
 }
