--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
--

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  { 'stevearc/conform.nvim', opts = {} },

  -- Git related plugins
  'tpope/vim-fugitive',

  {
    'kdheepak/lazygit.nvim',
    cmd = { 'LazyGit', 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'Open lazy git' },
  },
  'tpope/vim-rhubarb',
  -- find and replace plugin
  'nvim-lua/plenary.nvim',
  'nvim-pack/nvim-spectre',

  -- surround enter and delete key bindings
  'tpope/vim-surround',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  'nvim-lua/plenary.nvim',
  'ThePrimeagen/harpoon',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode', hidden = false, mode = { 'n', 'v' } },
        { '<leader>d', group = '[D]ocument', hidden = false },
        { '<leader>r', group = '[R]ename', hidden = false },
        { '<leader>s', group = '[S]earch', hidden = false },
        { '<leader>w', group = '[W]orkspace', hidden = false },
        { '<leader>t', group = '[T]oggle', hidden = false },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  -- for git diff viewing
  {
    'sindrets/diffview.nvim',
    opts = {},
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    keys = {
      { '<leader>gb', '<cmd>DiffviewOpen<CR>', desc = 'Open Diffview (HEAD vs current)' },
      { '<leader>gq', '<cmd>DiffviewClose<CR>', desc = 'Close Diffview' },
    },
  },
  -- plugin for sidebar file tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            -- '.git',
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
    },
  },
  -- amongst your other plugins
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, '<leader>hn', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '<leader>hp', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hl', ':Gitsigns setloclist<CR>', { desc = 'git hunk list' })
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hv', gs.preview_hunk, { desc = 'git hunk visualize' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'filename',
            path = 1, -- 0 = filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = {},
        -- lualine_y = { 'progress' },
        -- lualine_z = { 'location' },
      },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- set up copilot
  --
  -- { 'github/copilot.vim',      opts = {} },
  -- -- copilot chat
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },

  -- packages for debuggers
  -- initially for react and python debugging
  'mfussenegger/nvim-dap',
  'nvim-neotest/nvim-nio',
  'rcarriga/nvim-dap-ui',
  'theHamsta/nvim-dap-virtual-text',

  'antoinemadec/FixCursorHold.nvim',
  'nvim-neotest/neotest',
  'marilari88/neotest-vitest',
  'mxsdev/nvim-dap-vscode-js',

  { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true

-- remove search with Esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- This is a location list, similar to a quickfix list
-- but it is a location list, aka scoped to the file it is in.
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostics list' })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- float the lsp / linter error message
vim.keymap.set('n', '<leader>lm', vim.diagnostic.open_float, { desc = 'Float lint /  lsp error message' })
-- display/hide the lsp inline error message
vim.keymap.set('n', '<leader>ld', require('lsp_lines').toggle, { desc = 'Display toggle lsp_lines' })

-- remap half page jump up and down to center itself
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- location list key maps
-- Location list open/close
vim.keymap.set('n', '<leader>lo', ':lopen<CR>', { noremap = true, silent = true, desc = 'Location list open' })
vim.keymap.set('n', '<leader>lc', ':lclose<CR>', { noremap = true, silent = true, desc = 'Location list close' })
vim.keymap.set('n', '<leader>le', function()
  vim.fn.setloclist(0, {})
  vim.cmd 'lclose'
end, { desc = 'Location List empty', silent = true })

-- Location list Navigation
vim.keymap.set('n', '<leader>ln', ':lnext<CR>', { noremap = true, silent = true, desc = 'Location list next' })
vim.keymap.set('n', '<leader>lp', ':lprev<CR>', { noremap = true, silent = true, desc = 'Location list prev' })
vim.keymap.set('n', '<leader>lf', ':lfirst<CR>', { noremap = true, silent = true, desc = 'Location list first' })
vim.keymap.set('n', '<leader>ll', ':llast<CR>', { noremap = true, silent = true, desc = 'Location list last' })

-- copilot chat keymap
vim.keymap.set('n', '<leader>co', ':CopilotChatOpen<CR>', { desc = 'Open Copilot Chat' })
vim.keymap.set('n', '<leader>cs', ':CopilotChatStop<CR>', { desc = 'Stop Copilot Chat' })
vim.keymap.set('n', '<leader>cr', ':CopilotChatReset<CR>', { desc = 'Stop Copilot reset' })

-- Neotree keymaps
vim.keymap.set('n', '<leader>nf', ':Neotree git_status<CR>', { desc = 'Neotree git files' })
vim.keymap.set('n', '<leader>no', ':Neotree <CR>', { desc = 'Neotree open' })
vim.keymap.set('n', '<leader>nc', ':Neotree close<CR>', { desc = 'Neotree close' })

-- For Spectre find and replace

vim.keymap.set('n', '<leader>Sa', '<cmd>lua require("spectre").toggle()<CR>', { -- search all
  desc = 'Toggle Spectre all',
})
vim.keymap.set('n', '<leader>Sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('v', '<leader>Sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('n', '<leader>Sr', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = 'Search on current file',
})

-- config this myelf for a tree file visual
-- local setupNvimTree, nvimtree = pcall(require, "nvim-tree")
-- if not setupNvimTree then
--  return
-- end
-- vim.g.loaded = 1
-- vim.g.loaded_netrwPlugin = 1
-- nvimtree.setup()
-- require("nvim-tree").setup()
-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
--  vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
-- require("nvim-tree").setup()

-- OR setup with some options

-- for better lsp error message displays
require('lsp_lines').setup()
-- toggle it via <leader>l

-- remove the previous formatting
vim.diagnostic.config {
  virtual_text = false,
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`

-- Shared layout configuration
local custom_layout_config = {
  layout_strategy = 'horizontal',
  layout_config = {
    preview_width = 0.7,
    width = 0.99,
    height = 0.98,
    prompt_position = 'top',
  },
  sorting_strategy = 'ascending',
}

-- Custom find_files function
local find_files_custom_display = function()
  require('telescope.builtin').find_files(custom_layout_config)
end

-- Custom oldfiles function
local oldfiles_custom_display = function()
  require('telescope.builtin').oldfiles(custom_layout_config)
end

-- Custom livegrap function
local livegrep_custom_display = function()
  require('telescope.builtin').live_grep(custom_layout_config)
end

-- Custom find references function
local find_reference_custom_display = function()
  require('telescope.builtin').lsp_references(custom_layout_config)
end

vim.keymap.set('n', '<leader>?', oldfiles_custom_display, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find {
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.9,
      height = 0.4,
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    previewer = false,
  }
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', find_files_custom_display, {
  desc = '[S]earch [F]iles',
})
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>ss', ':Telescope git_status<cr>', { desc = '[S]earch git [S]tatus' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', livegrep_custom_display, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sp', ':Telescope harpoon marks<CR>', { desc = 'Harpoon Marks' })

-- harpoon
vim.keymap.set('n', '<leader>pm', require('harpoon.mark').add_file, { desc = 'harpoon mark' })
vim.keymap.set('n', '<leader>pn', require('harpoon.ui').nav_next, { desc = 'harpoon next' })
vim.keymap.set('n', '<leader>pp', require('harpoon.ui').nav_prev, { desc = 'harpoon prev' })
vim.keymap.set('n', '<leader>pa', require('harpoon.ui').toggle_quick_menu, { desc = 'harpoon menu' })
-- the following keymaps are for primagens harpoon config
-- https://github.com/ThePrimeagen/init.lua/blob/249f3b14cc517202c80c6babd0f9ec548351ec71/after/plugin/harpoon.lua
local ui = require 'harpoon.ui'
vim.keymap.set('n', '<leader>p1', function()
  ui.nav_file(1)
end)
vim.keymap.set('n', '<leader>p2', function()
  ui.nav_file(2)
end)
vim.keymap.set('n', '<leader>p3', function()
  ui.nav_file(3)
end)
vim.keymap.set('n', '<leader>p4', function()
  ui.nav_file(4)
end)

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', find_reference_custom_display, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- for git diff integration

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')

  -- formating / linting
  require('conform').setup {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'ruff', 'black' },
      -- Use a sub-list to run only the first available formatter
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 2000,
    },
  }
  -- format on save
  -- commented out right now since it was way to slow
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --  pattern = "*",
  --  callback = function(args)
  --    require("conform").format({ bufnr = args.buf })
  --  end,
  -- })
  -- format on f
  vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require('conform').format()
  end, { desc = 'Format file or range (in visual mode)' })

  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- this is so that it is easier to leave the terminal mode
vim.api.nvim_set_keymap('t', '<Leader><ESC>', '<C-\\><C-n>', { noremap = true })

-- set up harpoon
require('harpoon').setup {
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { 'harpoon' },

    -- set marks specific to each git branch inside git repository
    mark_branch = true,

    -- enable tabline with harpoon marks
    tabline = false,
    tabline_prefix = '   ',
    tabline_suffix = '   ',
  },
}
-- use telescope as our UI for harpoon
require('telescope').load_extension 'harpoon'

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- setup toggleterm --
require('toggleterm').setup {
  -- size can be a number or function which is passed the current terminal
  size = 13,
  open_mapping = [[<c-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  shading_factor = 2, -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
  direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  -- Change the default shell. Can be a string or a function returning a string
  shell = vim.o.shell,
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    border = 'curved',
    winblend = 0,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new {
  cmd = 'lazygit',
  hidden = true,
  direction = 'float',
}
-- Lazy git toggle
function LGT()
  lazygit:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>lg', ':lua LGT()<CR>', { noremap = true, silent = true })

-- Fugitive mappings
vim.api.nvim_set_keymap('n', '<leader>gS', ':Git<CR>', { noremap = true, silent = true, desc = 'Git status' })
vim.api.nvim_set_keymap('n', '<leader>gh', ':0GcLog<CR>', { noremap = true, silent = true, desc = 'Git commit log' })
vim.api.nvim_set_keymap(
  'n',
  '<leader>gf',
  ':Gvdiffsplit HEAD<CR>',
  { noremap = true, silent = true, desc = 'Git diff current file to previous file commit (includes staged and unstaged)' }
)
vim.keymap.set('n', '<leader>gu', ':Gvdiffsplit<CR>', {
  noremap = true,
  silent = true,
  desc = 'Git diff: unstaged changes only vs previous commit and current staged changes',
})

-- Copilot related stuff
require('CopilotChat').setup {
  model = 'claude-3.7-sonnet',
  window = {
    layout = 'float',
    width = 0.8, -- 60% of screen width
    height = 0.8, -- 70% of screen height
  },
}

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  rust_analyzer = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- Quickfix list
-- Map keys to quickly navigate and open the quickfix list
vim.api.nvim_set_keymap('n', '<leader>qo', ':copen<CR>', { noremap = true, silent = true, desc = 'Quickfix list open' })
-- add close_quickfix function here
vim.api.nvim_set_keymap('n', '<leader>qc', ':cclose<CR>', { noremap = true, silent = true, desc = 'Quickfix list close' })
vim.api.nvim_set_keymap('n', '<leader>qn', ':cnext<CR>', { noremap = true, silent = true, desc = 'Quickfix next' })
vim.api.nvim_set_keymap('n', '<leader>qp', ':cprev<CR>', { noremap = true, silent = true, desc = 'Quickfix prev' })
vim.api.nvim_set_keymap('n', '<leader>qf', ':cfirst<CR>', { noremap = true, silent = true, desc = 'Quickfix first' })
vim.api.nvim_set_keymap('n', '<leader>ql', ':clast<CR>', { noremap = true, silent = true, desc = 'Quickfix last' })
-- Empty the quickfix list

vim.keymap.set('n', '<leader>qe', function()
  vim.fn.setqflist({}, 'r')
  vim.cmd 'cclose'
end, { desc = 'Quickfix empty and close' })

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- Stuff for setting up debugging react and python?
require('dapui').setup()
require('nvim-dap-virtual-text').setup()
require('neotest').setup {
  adapters = {
    require 'neotest-vitest',
  },
}

vim.keymap.set('n', '<leader>bu', ":lua require('dapui').open()<CR>", { desc = 'Bugger ui' })
vim.keymap.set('n', '<leader>bc', ":lua require('dapui').close()<CR>", { desc = 'Bugger ui close' })
vim.keymap.set('n', '<leader>bt', ":lua require('dapui').toggle()<CR>", { desc = 'Bugger toggle' })

vim.keymap.set('n', '<leader>bs', ":lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set('n', '<leader>br', ":lua require('dap').step_over()<CR>")
vim.keymap.set('n', '<leader>bi', ":lua require('dap').step_into()<CR>")

-- If the debugger hasn’t started yet — it starts the debug session
-- If the debugger is already running and paused — it resumes execution
vim.keymap.set('n', '<leader>br', ":lua require('dap').continue()<CR>", { desc = 'Bugger run/continue' })

vim.keymap.set('n', '<leader>bd', ":lua require('neotest').run.run({strategy='dap'})<CR>")

local js_based_languages = {
  'typescript',
  'javascript',
  'typescriptreact',
  'javascriptreact',
}

local install_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter'
local vscode_js_debug_path = install_path

-- attaching to an existing chrome doesn't work since
-- it has to be in debug mode
-- also using the dap config to launch chrome doesn't work well
-- it is always so slow, therefore this function below allows me to easily launch
-- chrome in debug mode so that I can attach to it.
local function launch_chrome_debug()
  local chrome_cmd = [[
    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
    --remote-debugging-port=9222 \
    --user-data-dir=/tmp/chrome-debug-profile
  ]]
  -- Launch Chrome in the background
  vim.fn.jobstart(chrome_cmd, {
    detach = true,
  })
  print '🚀 Chrome launched with debugging port 9222.'
end

vim.keymap.set('n', '<leader>cl', launch_chrome_debug, { desc = 'Chrome launch' })

require('dap-vscode-js').setup {
  debugger_path = vscode_js_debug_path,
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'python' }, -- which adapters to register in nvim-dap
}

local dap = require 'dap'
for _, language in ipairs(js_based_languages) do
  dap.configurations[language] = {
    -- Debug single nodejs files
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
    },
    {
      type = 'pwa-chrome',
      request = 'launch',
      name = 'Launch Chrome',
      webRoot = '${workspaceFolder}/src',
      cwd = vim.fn.getcwd(),
      url = 'https://localhost:3030',
      sourceMaps = true,
      skipFiles = {
        '<node_internals>/**',
        '**/node_modules/**',
      },
    },
    -- attach to chrome that is opened in debug mode on port 9222
    -- look at function above function launch_chrome_debug
    -- for how to launch chrome debug correctly.
    -- use this one for most success
    {
      type = 'pwa-chrome',
      request = 'attach',
      name = 'Attach to Chrome (React) (best option), run after launch_chrome_debug',
      webRoot = '${workspaceFolder}/src',
      cwd = vim.fn.getcwd(),
      port = 9222, -- Must match the port from step 1

      url = 'https://localhost:3030',
      sourceMaps = true,
      -- userDataDir = false, -- ⬅️ use existing Chrome profile
    },
    {

      type = 'python',
      request = 'attach',
      name = 'attach python',
      connect = {
        host = 'localhost',
        port = 5678,
      },
      pathMappings = {
        {
          localRoot = '${workspaceFolder}',
          remoteRoot = '.',
        },
      },
    },
  }
end
dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = {
      vscode_js_debug_path .. '/js-debug/src/dapDebugServer.js',
      '${port}',
    },
  },
}
dap.adapters['pwa-chrome'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = {
      vscode_js_debug_path .. '/js-debug/src/dapDebugServer.js',
      '${port}',
    },
  },
}

dap.adapters['python'] = {
  type = 'server',
  host = 'localhost',
  port = 5678,
}
-- end of debugging stuff

-- Auto run :Neotree when Neovim starts
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  command = 'Neotree',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
