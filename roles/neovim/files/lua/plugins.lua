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

    use {
      "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use {
        "ur4ltz/surround.nvim",
        -- 単語選択→囲む：viw→s<char>
        -- 他の文字で囲む：sr<from><to>
        -- 囲み文字を削除する：sd<char>
        config = function() require"surround".setup {} end
    }

    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        vim.opt.list = true
        require"indent_blankline".setup {
          space_char_blankline = " ",
          show_current_context = true,
          show_current_context_start = true
        }
      end
    }

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

    -- TODO:便利機能がないか見てみる
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

    -- TODO:便利機能がないか見てみる
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
      "RRethy/vim-illuminate",
      config = function()
        -- default configuration
        require('illuminate').configure({
            -- providers: provider used to get references in the buffer, ordered by priority
            providers = {
                'lsp',
                'treesitter',
                'regex',
            },
            -- delay: delay in milliseconds
            delay = 100,
            -- filetype_overrides: filetype specific overrides.
            -- The keys are strings to represent the filetype while the values are tables that
            -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
            filetype_overrides = {},
            -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
            filetypes_denylist = {
                'dirvish',
                'fugitive',
            },
            -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
            filetypes_allowlist = {},
            -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
            -- See `:help mode()` for possible values
            modes_denylist = {},
            -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
            -- See `:help mode()` for possible values
            modes_allowlist = {},
            -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
            -- Only applies to the 'regex' provider
            -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
            providers_regex_syntax_denylist = {},
            -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
            -- Only applies to the 'regex' provider
            -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
            providers_regex_syntax_allowlist = {},
            -- under_cursor: whether or not to illuminate under the cursor
            under_cursor = true,
            -- large_file_cutoff: number of lines at which to use large_file_config
            -- The `under_cursor` option is disabled when this cutoff is hit
            large_file_cutoff = nil,
            -- large_file_config: config to use for large files (based on large_file_cutoff).
            -- Supports the same keys passed to .configure
            -- If nil, vim-illuminate will be disabled for large files.
            large_file_overrides = nil,
            -- min_count_to_highlight: minimum number of matches required to perform highlighting
            min_count_to_highlight = 1,
        })
      end
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end
    }

    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    use {
      -- Usage: https://github.com/numToStr/Comment.nvim#-usage
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
    }

    use { "kdheepak/lazygit.nvim",
      config = function()
        vim.api.nvim_set_keymap('n', '<leader>git', ':LazyGit<CR>',
                                {noremap = true})
      end
    }

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
      'mg979/vim-visual-multi',
      config = function()
        vim.cmd("let g:VM_maps = {}")
        vim.cmd("let g:VM_maps['Find Under'] = '<leader>m'")
      end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'mfussenegger/nvim-dap'}},
        config = function()
            require('telescope').setup()
            vim.api.nvim_set_keymap('n', '<leader>ff',
                                    '<Cmd>Telescope find_files<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fg',
                                    '<Cmd>Telescope live_grep<CR>',
                                    {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fo',
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
            vim.api.nvim_set_keymap('n', '<leader>fa',
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
            vim.api.nvim_set_keymap('n', '<leader>y',
                                    '<Cmd>Telescope yank_history<CR>',
                                    {noremap = true})
        end
        -- <C-x> go to file selection as a split
        -- <C-v> go to file selection as a vsplit
        -- <C-t> go to a file in a new tab
        --`<C-e>`: creates new file in current directory, creates new directory if the name contains a trailing '/'
    }

    use {
      "gbprod/yanky.nvim",
      config = function()
        require('telescope').load_extension('yank_history')
      end
    }

    use {
      "nvim-telescope/telescope-dap.nvim",
      requires = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
      config = function()
        require('telescope').load_extension('dap')
      end
    }

    use {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end
    }

    use {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup()
      end
    }

    use {
        "neovim/nvim-lspconfig",
        config = function()
          -- Mappings.
          -- See `:help vim.diagnostic.*` for documentation on any of the below functions
          local opts = { noremap=true, silent=true }
          vim.diagnostic.config({virtual_text = false})
          vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

          -- Use an on_attach function to only map the following keys
          -- after the language server attaches to the current buffer
          local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
          end
          require('lspconfig')['lua_ls'].setup{}
          require('lspconfig')['pyright'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
          }
          require('lspconfig')['rust_analyzer'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
            -- Server-specific settings...
            settings = {
              ["rust-analyzer"] = {}
            }
          }
          require('lspconfig')['bashls'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
          }
        end
    }

    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require('null-ls').setup({
          -- capabilities = capabilities,
          sources = {
            require('null-ls').builtins.diagnostics.luacheck.with({
              extra_args = {"--globals", "vim", "--globals", "awesome"},
            }),
            require('null-ls').builtins.diagnostics.yamllint,
            require('null-ls').builtins.formatting.rustfmt,
            require('null-ls').builtins.formatting.shfmt,
            require('null-ls').builtins.formatting.yamlfmt,
            require('null-ls').builtins.formatting.sql_formatter,
            require('null-ls').builtins.formatting.black
          },
        })
      end
    }

    use {
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    use {
      "hrsh7th/nvim-cmp",
      requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp-signature-help" },
      config = function()
        local cmp = require'cmp'
        cmp.setup {
          sources = cmp.config.sources({
            {name = 'nvim_lsp'},
            {name = 'nvim_lsp_signature_help'},
            {name = 'path'},
            {name = 'buffer'},
            {name = 'cmdline'},
            {name = 'git'},
          }),
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
        }
        -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local lspconfig = require('lspconfig')
        require('mason-lspconfig').setup_handlers {
          function(server_name)
            lspconfig[server_name].setup {
              capabilities = capabilities,
            }
          end,
        }
      end
    }

    use {
      'thinca/vim-qfreplace'
      -- grep -> select -> ctr-q -> Qfreplace -> edit&save
    }

    use { 'PedramNavid/dbtpal',
      config = function()
        local dbt = require('dbtpal')
        dbt.setup {
          -- Path to the dbt executable
          path_to_dbt = "dbt",

          -- Path to the dbt project, if blank, will auto-detect
          -- using currently open buffer for all sql,yml, and md files
          path_to_dbt_project = "",

          -- Path to dbt profiles directory
          path_to_dbt_profiles_dir = vim.fn.expand "~/.dbt",

          -- Search for ref/source files in macros and models folders
          extended_path_search = true,

          -- Prevent modifying sql files in target/(compiled|run) folders
          protect_compiled_files = true

        }

        -- Setup key mappings

        vim.keymap.set('n', '<leader>drf', dbt.run)
        vim.keymap.set('n', '<leader>drp', dbt.run_all)
        vim.keymap.set('n', '<leader>dtf', dbt.test)
        vim.keymap.set('n', '<leader>dm', require('dbtpal.telescope').dbt_picker)

        -- Enable Telescope Extension
        require'telescope'.load_extension('dbtpal')
        end,
     requires = { { 'nvim-lua/plenary.nvim' }, {'nvim-telescope/telescope.nvim'} }
    }

end)
