-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()
return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'heavenshell/vim-pydocstring',
        config = function()
            vim.cmd("let g:pydocstring_doq_path = '~/opt/anaconda3/bin/doq'")
            vim.cmd("let g:pydocstring_formatter = 'numpy'")
            vim.api.nvim_set_keymap('n', '<leader>pd', '<Cmd>Pydocstring<CR>',
                                    {noremap = true})
        end,
        ft = {'python'}
    }

    use {'davidgranstrom/nvim-markdown-preview'}

    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                ignore_install = {"javascript"}, -- List of parsers to ignore installing
                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = {"javascript"}, -- list of language that will be disabled
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false
                }
            }
        end,
        run = ':TSUpdate'
    }

    use {'cohama/lexima.vim'}

    use {
        "blackCauldron7/surround.nvim",
        -- 単語選択→囲む：viw→s<char>
        -- 他の文字で囲む：sr<from><to>
        -- 囲み文字を削除する：sd<char>
        config = function() require"surround".setup {} end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>ff',
                                    '<Cmd>Telescope find_files<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fg',
                                    '<Cmd>Telescope live_grep<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fl',
                                    '<Cmd>Telescope file_browser<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fp',
                                    '<Cmd>Telescope old_files<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fb',
                                    '<Cmd>Telescope buffers<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fh',
                                    '<Cmd>Telescope help_tags<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fc',
                                    '<Cmd>Telescope commands<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>ma',
                                    '<Cmd>Telescope marks<CR>', {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fh',
                                    '<Cmd>Telescope command_history<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fr',
                                    '<Cmd>Telescope registers<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>bf',
                                    '<Cmd>Telescope current_buffer_fuzzy_find<CR>',
                                    {noremap = true})
        end
    }

    use {
        "numtostr/FTerm.nvim",
        config = function()
            require'FTerm'.setup({
                dimensions = {height = 0.8, width = 0.8, x = 0.5, y = 0.5},
                border = 'single' -- or 'double'
            })

            vim.api.nvim_set_keymap('n', '<leader>git',
                                    "<Cmd>lua require('FTerm.terminal'):new():setup({cmd='gitui'}):toggle()<CR>",
                                    {noremap = true})
        end
    }

    use {'lukas-reineke/indent-blankline.nvim'}

    use {
        'Xuyuanp/scrollbar.nvim',
        config = function()
            vim.cmd(
                "autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()")
            vim.cmd(
                "autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()")
            vim.cmd(
                "autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()")
        end
    }

    -- use {'tyrannicaltoucan/vim-deep-space'}
    use {
        'folke/tokyonight.nvim',
        config = function()
            vim.cmd("colorscheme tokyonight")
        end
    }
    vim.g.tokyonight_style = "night"

    use {
        'akinsho/bufferline.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require("bufferline").setup()
            vim.api.nvim_set_keymap('n', '<C-p>', ':BufferLineCyclePrev<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<C-n>', ':BufferLineCycleNext<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<C-c>', ':BufferLinePickClose<CR>',
                                    {noremap = true})
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end
    }

    use {'tomtom/tcomment_vim'}

    use {
      'mfussenegger/nvim-dap',
      config = function()
        local dap = require('dap')
        dap.adapters.python = {
          type = 'executable';
          command = os.getenv('HOME') .. '/opt/anaconda3/bin/python';
          args = { '-m', 'debugpy.adapter' };
        }
        dap.configurations.python = {
          {
            type = 'python';
            request = 'launch';
            name = "launch file";
            program = "${file}";
            pythonpath = function()
              return os.getenv('HOME') .. '/opt/anaconda3/bin/python'
            end;
          },
        }
        vim.api.nvim_set_keymap('n', '<leader>con', "<cmd>lua require'dap'.continue()<cr>",
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>ne', "<cmd>lua require'dap'.step_over()<cr>",
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>sin', "<cmd>lua require'dap'.step_into()<cr>",
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>sout', "<cmd>lua require'dap'.step_out()<cr>",
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>B', "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>dr', "<cmd>lua require'dap'.repl_open()<cr>",
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>dl', "<cmd>lua require'dap'.run_last()<cr>",
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>val', "<cmd>lua require('dap.ui.widgets').hover()<cr>",
                                {noremap = false})
      end
    }

    use {
      'nvim-telescope/telescope-dap.nvim',
      config = function()
        require('telescope').load_extension('dap')
        vim.api.nvim_set_keymap('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<cr>',
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<cr>',
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<cr>',
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<cr>',
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<cr>',
                                {noremap = false})
      end
    }

    use {
      "rcarriga/nvim-dap-ui",
      config = function()
        vim.api.nvim_set_keymap('n', '<leader>dset', "<cmd>lua require('dapui').setup()<cr>",
                                {noremap = false})
        vim.api.nvim_set_keymap('n', '<leader>dtog', "<cmd>lua require('dapui').toggle()<cr>",
                                {noremap = false})
      end,
      requires = {
        "mfussenegger/nvim-dap"
      }
    }

    use {
      'neoclide/coc.nvim',
      branch = 'release',
      config = function()
          -- GoTo code navigation.
          vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)',
                                  {noremap = false})
          vim.api.nvim_set_keymap('n', '<leader>D',
                                  '<Plug>(coc-type-definition)',
                                  {noremap = false})
          vim.api.nvim_set_keymap('n', 'gi',
                                  '<Plug>(coc-implementation)',
                                  {noremap = false})
          vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)',
                                  {noremap = false})
          -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
          vim.api.nvim_set_keymap('n', '[d',
                                  '<Plug>(coc-diagnostic-prev)',
                                  {noremap = false})
          vim.api.nvim_set_keymap('n', ']d',
                                  '<Plug>(coc-diagnostic-next)',
                                  {noremap = false})
          -- Use K to show documentation in preview window.
          vim.api.nvim_set_keymap('n', 'K',
                                  '<Cmd>call CocActionAsync("doHover")<CR>',
                                  {noremap = true})
          -- Format
          vim.api.nvim_set_keymap('n', '<leader>fm',
                                  '<Cmd>call CocActionAsync("format")<CR>',
                                  {noremap = true})
          -- Yank list (coc-yank)
          vim.api.nvim_set_keymap('n', '<leader>y',
                                  '<Cmd>CocList -A --normal yank<CR>',
                                  {noremap = true})
          vim.g.coc_global_extensions = {'coc-json', 'coc-jedi', 'coc-sh', 'coc-metals', 'coc-yank'}
      end
    }

end)
