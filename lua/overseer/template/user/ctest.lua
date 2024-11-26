return {
  name = 'ctest',
  builder = function()
    local entry_dir = vim.fn.getenv 'NVIM_ENTRY_POINT'
    entry_dir = tostring(entry_dir)
    local build_dir
    if entry_dir ~= vim.NIL then
      build_dir = entry_dir .. '/build'
    else
      return {}
    end
    return {
      cmd = { 'ctest' },
      args = { '-V', '--test-dir', build_dir },
      components = { { 'on_output_quickfix', open_on_exit = 'failure' }, 'default' },
    }
  end,
}
