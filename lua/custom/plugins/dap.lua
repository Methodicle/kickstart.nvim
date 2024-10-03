return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      local mason_registry = require 'mason-registry'

      require('dapui').setup()
      require('dap-go').setup()
      require('nvim-dap-virtual-text').setup {}

      -- 1. Configure codelldb
      local codelldb = mason_registry.get_package 'codelldb'
      local codelldb_path = codelldb:get_install_path() .. '/extension/adapter/codelldb'

      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb_path,
          args = { '--port', '${port}' },
        },
      }

      dap.configurations.cpp = {
        {
          name = 'Launch C++ file with codelldb',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      -- You can also use the same configuration for C and Rust
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- Set keybindings for DAP
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<leader>gb', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<leader>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<leader>tr', dap.terminate)
      vim.keymap.set('n', '<F5>', dap.continue)
      vim.keymap.set('n', '<leader>si', dap.step_into)
      vim.keymap.set('n', '<F10>', dap.step_over)
      vim.keymap.set('n', '<leader>so', dap.step_out)
      vim.keymap.set('n', '<S-F5>', dap.restart)

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
