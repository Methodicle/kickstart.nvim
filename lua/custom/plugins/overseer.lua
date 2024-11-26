return {
  'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup {
      templates = { 'user.gcc_build', 'user.gcc_debug_build', 'user.cmake_debug', 'user.make', 'user.cmake', 'user.ctest' },
    }

    vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<CR>')
    vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<CR>')
    vim.keymap.set('n', '<leader>oq', '<cmd>OverseerQuickAction<CR>')
    vim.keymap.set('n', '<leader>cc', ':cclose<CR>')
  end,
}
