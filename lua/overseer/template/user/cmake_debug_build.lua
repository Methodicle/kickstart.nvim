return {
  -- This prints full script out, its not ideal but it works
  name = 'CMake debug build',
  builder = function()
    local function find_project_root()
      local dir = vim.fn.expand '%:p:h' -- Get the directory of the current file
      while dir ~= '/' do
        local cmake_file = dir .. '/CMakeLists.txt'
        if vim.fn.filereadable(cmake_file) == 1 then
          return dir -- Return the directory containing the topmost CMakeLists.txt
        end
        dir = vim.fn.fnamemodify(dir, ':h') -- Move to the parent directory
      end
      return nil -- Return nil if no CMakeLists.txt is found
    end

    local project_root = find_project_root()
    if not project_root then
      print 'Error: No CMakeLists.txt found in any parent directories.'
      return {} -- Return an empty table to indicate failure
    end
    local build_dir = project_root .. '/build'

    return {
      cmd = {
        'bash',
        '-c',
        string.format(
          [[
                CURRENT_DIR=$(pwd)
                cd "%s"

                BUILD_DIR="%s"

                if [ ! -d "$BUILD_DIR" ]; then
                    mkdir "$BUILD_DIR"
                fi

                cd "$BUILD_DIR"
                cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=clang++ .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
                make
                cd ..
                cp "$BUILD_DIR/compile_commands.json" .
                cd "$CURRENT_DIR"
                echo "Build complete, and compile_commands.json copied to project root."
                    ]],
          project_root,
          build_dir
        ),
      },
      components = { { 'on_output_quickfix', open_on_exit = 'failure' }, 'default' },
    }
  end,
}
