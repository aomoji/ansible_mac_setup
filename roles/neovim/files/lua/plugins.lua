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
                ensure_installed = {"bash", "fish", "python", "scala", "rust", "lua"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                ignore_install = {"javascript"}, -- List of parsers to ignore installing
                sync_install = true,
                auto_install = true,
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
        "ur4ltz/surround.nvim",
        -- 単語選択→囲む：viw→s<char>
        -- 他の文字で囲む：sr<from><to>
        -- 囲み文字を削除する：sd<char>
        config = function() require"surround".setup {} end
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

    use {
      'rebelot/kanagawa.nvim',
        config = function()
            vim.cmd("colorscheme kanagawa")
        end
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function()
        require'nvim-tree'.setup {}
        vim.api.nvim_set_keymap('n', '<leader>fl', ':NvimTreeToggle<CR>',
                                {noremap = true})
      end
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
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
      'mg979/vim-visual-multi',
      config = function()
        vim.cmd("let g:VM_maps = {}")
        vim.cmd("let g:VM_maps['Find Under'] = '<C-m>'")
      end
    }

    use {
      'SirVer/ultisnips',
      requires = {'honza/vim-snippets'},
      config = function()
        vim.g.UltiSnipsExpandTrigger = "<tab>"
        vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
        vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"
      end
    }

    use {
      'neoclide/coc.nvim',
      branch = 'release',
      requires = {
        'junegunn/fzf',
        { 'ryanoasis/vim-devicons', 
          config = function()
            vim.g.fzf_preview_use_dev_icons = 1
          end
        }
      },
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
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>ff',
                                  ':CocCommand fzf-preview.DirectoryFiles<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>fr',
                                  ':CocCommand fzf-preview.FromResources<Space>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>fg',
                                  ':CocCommand fzf-preview.ProjectGrep<Space>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>fo',
                                  ':CocCommand fzf-preview.ProjectOldFiles<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>fp',
                                  ':CocCommand fzf-preview.ProjectMruFiles<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>fh',
                                  ':CocCommand fzf-preview.CommandPalette<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>ma',
                                  ':CocCommand fzf-preview.Marks<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>re',
                                  ':CocCommand fzf-preview.Yankround<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>bl',
                                  ':CocCommand fzf-preview.BufferLines<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>qf',
                                  ':CocCommand fzf-preview.QuickFix<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>ch',
                                  ':CocCommand fzf-preview.Changes<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>git',
                                  ':CocCommand fzf-preview.GitActions<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>da',
                                  ':CocCommand fzf-preview.CocDiagnostics<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>dc',
                                  ':CocCommand fzf-preview.CocCurrentDiagnostics<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>ou',
                                  ':CocCommand fzf-preview.CocOutline<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          vim.api.nvim_set_keymap('n', '<leader>y',
                                  '<Cmd>CocList -A --normal yank<CR>',
                                  {noremap = true})
          -- (coc-fzf-preview)
          -- press ^Q to delete buffers
          vim.api.nvim_set_keymap('n', '<leader>fb',
                                  ':CocCommand fzf-preview.Buffers<CR>',
                                  {noremap = true})

          vim.g.coc_global_extensions = {'coc-json', 'coc-jedi', 'coc-sh', 'coc-metals', 'coc-yank', 'coc-sqlfluff', 'coc-fzf-preview', 'coc-lua', 'coc-rls'}
      end
    }

    use {
      'thinca/vim-qfreplace'
    }

    use {
      'lambdalisue/gina.vim'
    }

    use {
      "LeafCage/yankround.vim"
    }

    use { 'skanehira/jumpcursor.vim',
      config = function()
        vim.api.nvim_set_keymap('n', '<leader>j', "<Plug>(jumpcursor-jump)",
                                {noremap = false})
      end
    }

end)
