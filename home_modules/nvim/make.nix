{ pkgs, ... }:

{
  config = {
    home.packages = [
      pkgs.gcc
      pkgs.ghc
      pkgs.elixir
    ];

    homeModules.nvim.lua = [
      ''
        -- This could technically (i.e. should) be it's own plugin

        local function term_exec(cmd)
          if vim.env.TMUX ~= nil then
            local tmux_cmd = string.format('tmux send-keys -t 1 "%s" C-m', cmd)
            vim.fn.system(tmux_cmd)
          else
            local term_cmd = string.format('TermExec direction=horizontal cmd="%s" go_back=0', cmd)
            vim.cmd(term_cmd)
          end
        end

        local function term_build(cmd)
          if vim.env.TMUX ~= nil then
            local tmux_cmd = string.format('tmux send-keys -t 1 "%s" C-m', cmd)
            vim.fn.system(tmux_cmd)
          else
            vim.api.nvim_command('! ' .. cmd)
          end
        end

        local build_functions = {
          cpp = function()
            local filename = vim.fn.expand('%:p')
            local output_filename = vim.fn.expand('%:p:r')
            local command = string.format(
              'g++ -DLOCAL -Wall -Wextra "%s" -o "%s"',
              filename,
              output_filename
            )
            term_build(command)
          end,
          haskell = function()
            local filename = vim.fn.expand('%:p')
            local output_filename = vim.fn.expand('%:p:r')
            local command = string.format(
              'ghc "%s" -o "%s"',
              filename,
              output_filename
            )
            term_build(command)
          end,
        }

        local run_functions = {
          cpp = function()
            local cmd = vim.fn.expand('%:p:r')
            term_exec(cmd)
          end,
          python = function()
            local filename = vim.fn.expand('%:p')
            local cmd = string.format('python %s', filename)
            term_exec(cmd)
          end,
          elixir = function()
            local filename = vim.fn.expand('%:p')
            local cmd = string.format('elixir %s', filename)
            term_exec(cmd)
          end,
          haskell = function()
            local cmd = vim.fn.expand('%:p:r')
            term_exec(cmd)
          end,
        }

        local function check_script(script)
          local f = io.open(script, 'r')
          if f == nil then
            return false
          end
          io.close(f)
          return true
        end

        local function run_from_script(script)
          term_exec(script)
        end

        local function build_from_script(script)
          term_exec(script)
        end

        local function run_program()
          local shell_script = vim.fn.getcwd() .. '/run.sh'
          if check_script(shell_script) then
            run_from_script(shell_script)
            return
          end

          local filetype = vim.bo.filetype

          if run_functions[filetype] then
            run_functions[filetype]()
          else
            print("No run function defined for filetype: " .. filetype)
          end
        end

        local function build_program()
          local shell_script = vim.fn.getcwd() .. '/build.sh'
          if check_script(shell_script) then
            build_from_script(shell_script)
            return
          end

          local filetype = vim.bo.filetype

          if build_functions[filetype] then
            build_functions[filetype]()
          else
            print("No build function defined for filetype: " .. filetype)
          end
        end

        vim.keymap.set('n', '<leader>b', build_program, { desc = 'Make | Build Program', silent = true })
        vim.keymap.set('n', '<leader>r', run_program, { desc = 'Make | Run Program', silent = true })
      ''
    ];
  };
}
