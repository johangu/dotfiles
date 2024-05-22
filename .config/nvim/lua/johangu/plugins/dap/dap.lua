return {
  'mfussenegger/nvim-dap',
  keys = {
    { '<leader>b', function() require 'dap'.toggle_breakpoint() end, desc = 'Debug: Breakpoint' },
    {
      '<leader>B',
      function()
        require 'dap'.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint'
    }
  },
  dependencies = {
    {
      'theHamsta/nvim-dap-virtual-text',
      config = true,
    },
    {
      'rcarriga/nvim-dap-ui',
      opts = {
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
      },
    },
    {
      'jay-babu/mason-nvim-dap.nvim',
      opts = {
        automatic_setup = true,
        handlers = {},
        ensure_installed = {},
      }
    }
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    vim.fn.sign_define('DapBreakpoint', {
      text = '●',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = ''
    })
    vim.fn.sign_define('DapBreakpointCondition', {
      text = '●',
      texthl = 'DapBreakpointCondition',
      linehl = '',
      numhl = ''
    })
    vim.fn.sign_define('DapLogPoint', {
      text = '◆',
      texthl = 'DapLogPoint',
      linehl = '',
      numhl = ''
    })

    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
