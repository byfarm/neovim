-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {

  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python'
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- dap.adapters.python = {
    --   type = "excecutable",
    --   command = 'poetry',
    --   args = { 'run', 'python3', '-m', 'debugpy.adapter' }
    -- }
    -- dap.configurations.python = {
    --   type = 'python',
    --   request = 'launch',
    --   name = "Launch file",
    --   program = "${file}"
    -- }
      dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
  detached = false,
  }
}
    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'python',
        'codelldb'
      },
    }
    vim.keymap.set('n', '<F5>', function()
      dap.continue()
    end)
    vim.keymap.set('n', '<F11>', dap.step_into)
    vim.keymap.set('n', '<F10>', dap.step_over)
    vim.keymap.set('n', '<S-F11>', dap.step_out)
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end)
    
    -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<F7>", dapui.toggle)
    
    -- Debug breakpoint will be in color
    vim.api.nvim_set_hl(0, "blue",   { fg = "#3d59a1", bg = "#FFFF00" })
    vim.api.nvim_set_hl(0, "green",  { fg = "#9ece6a", bg = "#FFFF00" }) 
    vim.api.nvim_set_hl(0, "yellow", { fg = "#FAFA33", bg = "#FFFa05" }) 
    vim.api.nvim_set_hl(0, "black", { fg = "#000000", bg = "#FFFF00" })
    vim.fn.sign_define('DapBreakpoint',{ text = '🐞', texthl='blue',linehl='black', numhl='yellow' })
    vim.fn.sign_define('DapStopped',{ text="", texthl='green',linehl='black', numhl='yellow' })
        -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
    require('dap-python').setup('~/.virtualenvs/python310/bin/python')
    -- require('dap-python').setup("/home/bucks/.cache/pypoetry/virtualenvs/scrapers-xlDQeP5F-py3.10/bin/python3")


  end 
}
