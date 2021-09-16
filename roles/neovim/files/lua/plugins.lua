-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'neovim/nvim-lspconfig',
    config = function()
      local nvim_lsp = require('lspconfig')

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        --Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
      end

      -- Use a loop to conveniently call 'setup' on multiple servers and
      -- map buffer local keybindings when the language server attaches
      -- Follow the nvim-lspconfig's install guide
      local servers = { "pylsp" }
      for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
          on_attach = on_attach,
          flags = {
            debounce_text_changes = 150,
          }
        }
      end
    end
  }

  use {
    'mhartington/formatter.nvim',
    config = function()
      require('formatter').setup({
        logging = false,
        filetype = {
          python = {
              -- black
             function()
                return {
                  exe = "~/opt/anaconda3/bin/black",
                  args = { vim.api.nvim_buf_get_name(0) },
                  stdin = false
                }
             end
          },
          json = {
            -- json
            function()
              return {
                exe = "python -m json.tool",
                args = { vim.api.nvim_buf_get_name(0) },
                stdin = true 
              }
            end 
          }
        }
      })
      vim.api.nvim_exec([[
      augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost *.py,*.json FormatWrite
      augroup END
      ]], true)
      vim.api.nvim_set_keymap('n', '<leader>fm', '<Cmd>Format<CR>', {noremap = true})
    end
  }

  use {
    'heavenshell/vim-pydocstring',
    config = function()
      vim.cmd("let g:pydocstring_doq_path = '~/opt/anaconda3/bin/doq'")
      vim.cmd("let g:pydocstring_formatter = 'numpy'")
      vim.api.nvim_set_keymap('n', '<leader>pd', '<Cmd>Pydocstring<CR>', {noremap = true})
    end,
    ft = {'python'}
  }



  use {
    'nvim-lua/completion-nvim',
    config = function()
      require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
      vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
      vim.cmd('set completeopt=menuone,noinsert,noselect')
      vim.cmd('set shortmess+=c')
    end,
    requires = {'neovim/nvim-lspconfig'}
  }

  use {
    'davidgranstrom/nvim-markdown-preview'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        ignore_install = { "javascript" }, -- List of parsers to ignore installing
        highlight = {
          enable = true,              -- false will disable the whole extension
          disable = { "javascript" },  -- list of language that will be disabled
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end,
    run = ':TSUpdate'
  }

  use {
    'cohama/lexima.vim'
  }

  use {
    "blackCauldron7/surround.nvim",
    -- 単語選択→囲む：viw→s<char>
    -- 他の文字で囲む：sr<from><to>
    config = function()
      require "surround".setup {}
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>fl', '<Cmd>Telescope file_browser<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>fp', '<Cmd>Telescope old_files<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>fc', '<Cmd>Telescope commands<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>ma', '<Cmd>Telescope marks<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>fh', '<Cmd>Telescope command_history<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>fr', '<Cmd>Telescope registers<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>bf', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', {noremap = true})
    end,
  }


  use {
    "numtostr/FTerm.nvim",
    config = function()
      require'FTerm'.setup({
        dimensions  = {
          height = 0.8,
          width = 0.8,
          x = 0.5,
          y = 0.5
        },
        border = 'single' -- or 'double'
      })

      vim.api.nvim_set_keymap('n', '<leader>git', "<Cmd>lua require('FTerm.terminal'):new():setup({cmd='gitui'}):toggle()<CR>", {noremap = true})
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim'
  }

  use {
    'Xuyuanp/scrollbar.nvim',
    config = function()
      vim.cmd("autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()")
      vim.cmd("autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()")
      vim.cmd("autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()")
    end
  }

  use {
    'tyrannicaltoucan/vim-deep-space'
  }

  use {
    'akinsho/bufferline.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require("bufferline").setup()
      vim.api.nvim_set_keymap('n', '<C-p>', ':BufferLineCyclePrev<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<C-n>', ':BufferLineCycleNext<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<C-c>', ':BufferLinePickClose<CR>', {noremap = true})
    end
  }
  vim.g.bufferline = {
    icon_close_tab = 'X'
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'tomtom/tcomment_vim'
  }

  use{
    'scalameta/coc-metals',
    ft = { 'scala' },
    requires = {
      {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
          -- GoTo code navigation.
          vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {noremap = false})
          vim.api.nvim_set_keymap('n', '<leader>D', '<Plug>(coc-type-definition)', {noremap = false})
          vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {noremap = false})
          vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {noremap = false})
          -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
          vim.api.nvim_set_keymap('n', '[d', '<Plug>(coc-diagnostic-prev)', {noremap = false})
          vim.api.nvim_set_keymap('n', ']d', '<Plug>(coc-diagnostic-next)', {noremap = false})
          -- Use K to show documentation in preview window.
          vim.api.nvim_set_keymap('n', 'K', '<Cmd>call CocActionAsync("doHover")<CR>', {noremap = true})
          -- Format
          vim.api.nvim_set_keymap('n', '<leader>fm', '<Cmd>call CocActionAsync("format")<CR>', {noremap = true})
         end
      }
    }
  }

end)
