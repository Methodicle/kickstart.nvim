return {
  name = 'CMake debug',
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
      cmd = { 'cmake' },
      args = { '-S', '.', '-B', build_dir, '-DCMAKE_BUILD_TYPE=Debug', '-DCMAKE_CXX_COMPILER=clang++', '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON' },
      components = { { 'on_output_quickfix', open_on_exit = 'failure' }, 'default' },
    }
  end,
}
