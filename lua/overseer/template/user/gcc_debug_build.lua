return {
  name = 'g++ debug build',
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand '%:p'
    local filename = vim.fn.expand '%:r'
    return {
      cmd = { 'g++' },
      args = { file, '-g', '-o', filename },
      components = { { 'on_output_quickfix', open_on_exit = 'failure' }, 'default' },
    }
  end,
  condition = {
    filetype = { 'cpp' },
  },
}
