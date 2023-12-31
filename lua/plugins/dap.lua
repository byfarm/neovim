local function read_env_vars()
    local dictionary = {}
    local cwd = vim.fn.getcwd()

    -- Open the file in read mode
    local file = io.open(cwd .. "/.env", "r")

    -- Check if the file is successfully opened
    if file then
        -- Read each line from the file
        for line in file:lines() do
            -- Split the line into key and value using "=" as the delimiter
            local key, value = line:match("([^=]+)=([^=]+)")

            -- Add the key-value pair to the dictionary
            if key and value then
                dictionary[key] = value
            end
        end

        -- Close the file
        file:close()
    else
        print("Error opening .env file")
    end

    return dictionary
end

return {
    'mfussenegger/nvim-dap',
	dependencies = {
	    -- Creates a beautiful debugger UI
		'rcarriga/nvim-dap-ui',

		-- Installs the debug adapters for you
		'williamboman/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',

		-- Add your own debuggers here
		'mfussenegger/nvim-dap-python'
	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'

		require('mason-nvim-dap').setup {
		  automatic_setup = true,
		  handlers = {},
		  ensure_installed = {
			'python',
		  },
		  automatic_installation = true,
		}

		vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
		vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
		vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
		vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
		vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
		vim.keymap.set('n', '<leader>B', function()
		  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
		end, { desc = 'Debug: Set Breakpoint' })

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
		-- require('dap-python').setup('~/.virtualenvs/python311/bin/python3')
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python3')

    table.insert(require("dap").configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'ENV VARS',
      program = '${file}',
      env = {'${env:SCRAPING_FISH_KEY}'}
    })

  end,
}

