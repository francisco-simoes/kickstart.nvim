--[[

Built on top of Kickstart.nvim

--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 4

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', ']e', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next [E]rror message' })
vim.keymap.set('n', '[e', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous [E]rror message' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Extra options and (non-plugin) keymaps by fsimoes ]]
-- Proper white background with tokyonight-day theme
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'tokyonight-day',
  callback = function()
    -- vim.api.nvim_set_hl(0, 'Normal', { bg = '#ffffff' }) -- pure white
    -- vim.api.nvim_set_hl(0, 'Normal', { bg = '#e8e8e8'}) -- light gray
    -- Note: the above set fg to None, so need to do the following:
    vim.schedule(function() -- set bg to light gray while keeping fg color the one from the theme
      local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
      vim.api.nvim_set_hl(
        0,
        'Normal',
        vim.tbl_extend('force', normal, {
          bg = '#e8e8e8',
        })
      )
    end)

    --     vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#ffffff' }) -- floating windows
    --     vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#f5f5f5' }) -- non-active windows with very light gray
    --
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#cefece' })
    --     vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = '#ffffff' })
    --     vim.api.nvim_set_hl(0, 'LineNr', { bg = '#f5f5f5' }) -- line number column
    --     vim.api.nvim_set_hl(0, 'FoldColumn', { bg = '#f5f5f5' }) -- fold indicators
    --     vim.api.nvim_set_hl(0, 'Folded', {
    --       fg = '#666666',
    --       bg = '#eeeeee',
    --     })
    --     vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#f5f5f5' }) -- gutter
    --
    --     vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = white })
    --     vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = white })
    --     vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = gray })
    --     vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = gray, fg = '#e0e0e0' })
    --     vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = white, fg = '#e0e0e0' })
    --     vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = white, fg = '#e0e0e0' })
    --     vim.api.nvim_set_hl(0, 'TelescopeSelection', {
    --       bg = '#cefece',
    --       fg = 'NONE',
    --     })
    -- vim.api.nvim_set_hl(0, '@org.agenda.scheduled', { -- scheduled elements in org agenda
    --   fg = '#e0af68',
    --   bold = false,
    -- })
  end,
})

-- Darker non-focused windows in all themes
local function darken(color, factor)
  local r = math.floor(tonumber(color:sub(2, 3), 16) * factor)
  local g = math.floor(tonumber(color:sub(4, 5), 16) * factor)
  local b = math.floor(tonumber(color:sub(6, 7), 16) * factor)
  return string.format('#%02x%02x%02x', r, g, b)
end

local function set_normal_nc()
  -- extract theme's bg and fg, to then re-use fg and only change bg
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
  if not normal.bg then
    return
  end

  local bg = string.format('#%06x', normal.bg)
  vim.api.nvim_set_hl(0, 'NormalNC', {
    bg = darken(bg, 0.9), -- tweak factor here
    fg = normal.fg, -- reuse fg
  })
end

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = set_normal_nc,
})

set_normal_nc()

-- To conceal links in orgmode
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'

-- Not folded when opening new buffer; but foldable
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99

-- Nerd font stuff
vim.o.guifont = 'JetBrainsMono Nerd Font:h12' -- To configure e.g. the size
vim.g.have_nerd_font = true -- I have a nerd font installed, so let nvim (and telescope in particular) use it

-- Neovide stuff
if vim.g.neovide == true then
  local max_scale = 3.0
  local min_scale = 0.3
  vim.keymap.set('n', '<C-=>', function()
    vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1, max_scale)
    -- vim.notify('Scale:' .. vim.g.neovide_scale_factor)
  end)
  vim.keymap.set('n', '<C-->', function()
    vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1, min_scale)
  end)
  vim.api.nvim_set_keymap('n', '<C-0>', ':lua vim.g.neovide_scale_factor = 1.0<CR>', { silent = true })
  -- vim.api.nvim_set_keymap('n', '<C-+>', ':lua vim.g.neovide_transparency = math.min(vim.g.neovide_transparency + 0.05, 1.0)<CR>', { silent = true })
  -- vim.api.nvim_set_keymap('n', '<C-_>', ':lua vim.g.neovide_transparency = math.max(vim.g.neovide_transparency - 0.05, 0.0)<CR>', { silent = true })
  -- vim.api.nvim_set_keymap('n', '<C-)>', ':lua vim.g.neovide_transparency = 0.9<CR>', { silent = true })
end

-- pynvim provider in venv
-- vim.g.python3_host_prog = vim.fn.expand '~/.virtualenvs/pynvim/bin/python' -- only needed if using UltiSnips

-- 2 space tabs in tex and lua files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'tex', 'lua' },
  callback = function()
    vim.opt_local.tabstop = 2 -- visual width of tab
    vim.opt_local.shiftwidth = 2 -- indentation size of >>
    vim.opt_local.softtabstop = 2 -- number of spaces inserted
    vim.opt_local.expandtab = true -- use spaces instead of tab characters
  end,
})

-- Automatically activate spell check in certain filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'tex', 'markdown', 'org' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { 'en_us' }
  end,
})

-- Doom-like copy current file path
vim.keymap.set('n', '<leader>fy', '<cmd>let @+ = expand("%:p")<CR>', { desc = 'Yank current file path' })

-- Doom-like quitting
vim.keymap.set('n', '<leader>qq', ':qa<CR>', { desc = '[Q]uit Neovim' })

-- Doom-like window management and movement
-- local std_sess_path = vim.fn.expand '~/.nvim_sessions/stdsess.vim'
-- local function save_session_to_stdsess(cmd)
--   vim.cmd('mksession! ' .. std_sess_path)
-- end
-- local function load_stdsess() -- Not working well...
--   vim.cmd('source ' .. std_sess_path)
-- end

vim.keymap.set('n', '<leader>wh', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>wl', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>wj', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>wk', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>wH', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<leader>wL', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<leader>wJ', '<C-w>J', { desc = 'Move window to down' })
vim.keymap.set('n', '<leader>wK', '<C-w>K', { desc = 'Move window to up' })

vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>wc', '<C-w>c', { desc = 'Close window' })
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = 'Close window' })
vim.keymap.set('n', '<leader>wmm', '<C-w><C-O>', { desc = 'Maximize window' })
-- TODO: Maximize horizontally and vertically
vim.keymap.set('n', '<leader>w-', '<C-w>-', { desc = 'Decrease current window height by pre-fixed N (default 1)' })
vim.keymap.set('n', '<leader>w+', '<C-w>+', { desc = 'Increase current window height by pre-fixed N (default 1)' })
vim.keymap.set('n', '<leader>w<', '<C-w><', { desc = 'Decrease current window width by pre-fixed N (default 1)' })
vim.keymap.set('n', '<leader>w>', '<C-w>>', { desc = 'Increase current window width by pre-fixed N (default 1)' })

-- Doom-like buffer management
vim.keymap.set('n', '<leader>bk', function()
  -- Switch to the previous buffer (alternate buffer)
  -- The | separates commands
  -- bd# deletes the alternate buffer (which was the current one)
  vim.cmd 'bnext | bdelete #'
end, { noremap = true, silent = true, desc = '[K]ill current [B]uffer' })

vim.keymap.set('n', '<leader>b]', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>b[', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })

-- Emacs-like (Lua) code execution from buffer
vim.keymap.set('v', '<leader>cl', "<cmd>'<,'>lua<CR>", { desc = 'Run selection as Lua code' }) -- TODO: not working!
-- print 'ok' -- to test lua code selection run

-- Open command line window / command history window
vim.keymap.set('n', '<leader>Hc', 'q:', { desc = 'Open [C]ommand [H]istory window (Ex commands)' })
vim.keymap.set('n', '<M-.>', 'q:', { desc = 'Open [C]ommand [H]istory window (Ex commands)' })
vim.keymap.set('n', '<leader>H/', 'q/', { desc = 'Open [S]earch [H]istory window' })

-- Save file
vim.keymap.set('n', '<leader>fs', '<cmd>w<CR>', { desc = '[S]ave current [F]ile' })

-- Visual selection of previously pasted text
vim.keymap.set('n', 'gp', '`[v`]', { desc = 'Select pasted text' })

-- Define the Telescope Project Picker keymap
vim.keymap.set('n', '<leader>pp', function()
  require('telescope').extensions.project.project {}
end, {
  noremap = true,
  silent = true,
  desc = 'Open project',
})

-- Define the Telescope bibtex Picker keymap
vim.keymap.set('n', '<leader>sl', '<cmd>Telescope bibtex<CR>', { desc = 'Search Library' })

-- Open pdf files with xdg-open
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*.pdf',
  callback = function()
    local file = vim.fn.expand '%:p'
    -- vim.fn.jobstart({ 'xdg-open', file }, { detach = true })
    vim.fn.jobstart({ 'okular', file }, { detach = true })
    vim.cmd 'bdelete!'
  end,
})

-- Open terminal in buffer directory
vim.keymap.set('n', '<leader>ot', function()
  local dir = vim.fn.expand '%:p:h'
  if dir == '' then
    dir = vim.fn.getcwd()
  end
  vim.fn.jobstart({ 'xfce4-terminal', '--working-directory', dir }, { detach = true })
end, { desc = "Open external terminal in current buffer's directory" })

-- Automatically change cwd to parent dir with .git after entering a buffer
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local root = vim.fs.root(0, { '.git' })
    if root then
      vim.cmd('cd ' .. root)
    end
  end,
})

-- =====================================================
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>c', group = '[C]ode operations' },
        { '<leader>H', group = '[H]istory' },
        { '<leader>g', group = 'Neo[G]it' },
        { '<leader>w', group = '[W]indow' },
        { '<leader>f', group = '[F]iles' },
        { '<leader>q', group = 'Session' },
        { '<leader>S', group = '[S]nippet stuff' },
      },
    },
  }, -- END of whick-key

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      -- local vars to help in setup of telescope-bibtex
      local bibtex_actions = require 'telescope-bibtex.actions'
      local action_state = require 'telescope.actions.state'
      local actions = require 'telescope.actions'
      local job = require 'plenary.job'
      local project_actions = require 'telescope._extensions.project.actions'

      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          path_display = { 'truncate' },
          mappings = {
            i = { ['<C-h>'] = 'which_key' },
            n = { ['<C-h>'] = 'which_key', ['?'] = 'which_key' },
          },
        },

        pickers = { -- Can change defaults for some of the pickers
          find_files = { hidden = true },
        },

        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },

          -- telescope-project config
          project = {
            base_dirs = {
              { path = '~/Documents', max_depth = 10 }, -- searches here for projects
              { path = '~/.config', max_depth = 5 }, -- searches here for projects
            },
            ignore_missing_dirs = true, -- default: false
            hidden_files = true, -- default: false
            theme = 'dropdown',
            hide_workspace = true, -- not useful info for me
            order_by = 'asc',
            search_by = 'title',
            -- sync_with_nvim_tree = true, -- default false
            -- default for on_project_selected = find project files
            -- on_project_selected = function(prompt_bufnr)
            -- Do anything you want in here. For example:
            -- project_actions.change_working_directory(prompt_bufnr, false)
            -- require('harpoon.ui').nav_file(1)
            -- end,
            mappings = {
              n = {
                ['d'] = project_actions.delete_project,
                ['r'] = project_actions.rename_project,
                ['c'] = project_actions.add_project,
                ['C'] = project_actions.add_project_cwd,
                ['f'] = project_actions.find_project_files,
                ['b'] = project_actions.browse_project_files,
                ['s'] = project_actions.search_in_project_files,
                ['R'] = project_actions.recent_project_files,
                ['w'] = project_actions.change_working_directory,
                ['o'] = project_actions.next_cd_scope,
              },
              i = {
                ['<c-d>'] = project_actions.delete_project,
                ['<c-v>'] = project_actions.rename_project,
                ['<c-a>'] = project_actions.add_project,
                ['<c-A>'] = project_actions.add_project_cwd,
                ['<c-f>'] = project_actions.find_project_files,
                ['<c-b>'] = project_actions.browse_project_files,
                ['<c-s>'] = project_actions.search_in_project_files,
                ['<c-r>'] = project_actions.recent_project_files,
                ['<c-l>'] = project_actions.change_working_directory,
                ['<c-o>'] = project_actions.next_cd_scope,
              },
            },
          },

          -- telescope-bibtex config
          bibtex = {
            -- Depth for the *.bib file
            depth = 1,
            -- Custom format for citation label
            custom_formats = {},
            -- Format to use for citation label.
            -- Try to match the filetype by default, or use 'plain'
            format = '',
            -- Path to global bibliographies (placed outside of the project)
            global_files = { '~/Documents/Library/library.bib' },
            -- Define the search keys to use in the picker
            search_keys = { 'author', 'year', 'title' },
            -- Template for the formatted citation
            citation_format = '{{author}} ({{year}}), {{title}}.',
            -- Only use initials for the authors first name
            citation_trim_firstname = true,
            -- Max number of authors to write in the formatted citation
            -- following authors will be replaced by "et al."
            citation_max_auth = 2,
            -- Context awareness disabled by default
            context = false,
            -- Fallback to global/directory .bib files if context not found
            -- This setting has no effect if context = false
            context_fallback = true,
            -- Wrapping in the preview window is disabled by default
            wrap = false,
            -- user defined mappings
            mappings = {
              i = {
                ['<CR>'] = function(prompt_bufnr)
                  local entry = action_state.get_selected_entry().id.content
                  actions.close(prompt_bufnr)

                  entry = table.concat(entry, '\n')

                  local key = entry:match '@%w+%s*{%s*([^,]+),'
                  if not key then
                    return
                  end

                  local library = vim.fn.expand '~/Documents/Library'
                  local target = key .. '.pdf'

                  job
                    :new({
                      command = 'fd',
                      args = { '--type', 'f', target, library },
                      on_exit = function(j, return_val)
                        if return_val ~= 0 then
                          return
                        end
                        local results = j:result()
                        if #results > 0 then
                          job
                            :new({
                              command = 'open',
                              args = { results[1] },
                              detached = true,
                            })
                            :start()
                        end
                      end,
                    })
                    :start()
                end,
              },
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

      for _, key_sequence in ipairs { '<leader>sf', '<leader>ff' } do
        vim.keymap.set('n', key_sequence, builtin.find_files, { desc = '[S]earch [F]iles in cwd' })
      end

      vim.keymap.set('n', '<leader>fh', function()
        require('telescope.builtin').find_files {
          cwd = '$HOME',
        }
      end, {
        desc = 'Search Files in the home directory',
      })

      for _, key_sequence in ipairs { '<leader>f.', '<leader>.' } do
        vim.keymap.set('n', key_sequence, function()
          -- vim.fn.expand('%:h') expands the Vim/Neovim variable '%:h' (current file's directory)
          require('telescope.builtin').find_files {
            cwd = vim.fn.expand '%:h',
          }
        end, {
          desc = "Find files in current buffer's directory",
        })
      end

      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      -- vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Search [R]ecent [F]iles ("." for repeat)' })
      vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Search existing [B]uffers' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch existing [B]uffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  }, -- END of fuzzy finder

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        -- version = '2.*',
        -- event = 'InsertEnter',
        -- config = function()
        --   local ls = require 'luasnip'
        --   vim.keymap.set({ 'i', 's' }, '<C-k>', function()
        --     ls.expand()
        --   end, { silent = true })
        --   require('luasnip').config.set_config { enable_autosnippets = true, updateevents = 'TextChanged,TextChangedI' }
        --   require('luasnip.loaders.from_lua').lazy_load { paths = vim.fn.stdpath 'config' .. '/lua/custom/plugins/luasnip' }
        -- end,
        -- build = (function()
        --   -- Build Step is needed for regex support in snippets.
        --   -- This step is not supported in many windows environments.
        --   -- Remove the below condition to re-enable on windows.
        --   if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        --     return
        --   end
        --   return 'make install_jsregexp'
        -- end)(),
        -- dependencies = {
        --   -- `friendly-snippets` contains a variety of premade snippets.
        --   --    See the README about individual language/framework/plugin snippets:
        --   --    https://github.com/rafamadriz/friendly-snippets
        --   -- {
        --   --   'rafamadriz/friendly-snippets',
        --   --   config = function()
        --   --     require('luasnip.loaders.from_vscode').lazy_load { exclude = { 'javascript' } }
        --   --   end,
        --   -- },
        -- },
        -- -- opts = { enable_autosnippets = true },
      }, -- END of luasnip
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default', -- default presets, including <C-y> to accept
        -- preset = 'super-tab',
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
        ['<C-k>'] = false, -- free up C-k

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        per_filetype = { org = { 'orgmode' } },
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          orgmode = {
            name = 'Orgmode',
            module = 'orgmode.org.autocompletion.blink',
            fallbacks = { 'buffer' },
          },
        },
      },

      snippets = {
        preset = 'luasnip',
        -- For `snippets.preset == 'luasnip'`
        -- opts = {
        --   -- Whether to use show_condition for filtering snippets
        --   use_show_condition = true,
        --   -- Whether to show autosnippets in the completion list
        --   show_autosnippets = true,
        --   -- Whether to prefer docTrig placeholders over trig when expanding regTrig snippets
        --   prefer_doc_trig = false,
        --   -- Whether to put the snippet description in the label description
        --   use_label_description = false,
        -- },
      },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  }, -- END of blink

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.colorscheme 'tokyonight-day'
    end,
  },

  { 'neanias/everforest-nvim' },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup {
        custom_textobjects = {
          -- $ as delimiter
          ['$'] = require('mini.ai').gen_spec.pair('$', '$', { type = 'greedy' }),
          -- Whole buffer
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line '$',
              col = math.max(vim.fn.getline('$'):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
        n_lines = 500,
      }

      -- automatic parenthesis etc. closing
      require('mini.pairs').setup {
        mappings = {
          ['`'] = false,
        },
      }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup {
        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,

        -- Module mappings. Use `''` (empty string) to disable one.
        -- mappings = { -- Defaults
        --   add = 'sa', -- Add surrounding in Normal and Visual modes
        --   delete = 'sd', -- Delete surrounding
        --   find = 'sf', -- Find surrounding (to the right)
        --   find_left = 'sF', -- Find surrounding (to the left)
        --   highlight = 'sh', -- Highlight surrounding
        --   replace = 'sr', -- Replace surrounding
        --
        --   suffix_last = 'l', -- Suffix to search with "prev" method
        --   suffix_next = 'n', -- Suffix to search with "next" method
        -- },

        -- Uncomment this paragraph to it Doom-like (and tpope/surround-like)
        mappings = { -- TODO: Make <leader>Sa etc also work, so that all surround functionality from mini.surround can be accessed through <leader>S
          add = 'S', -- Add surrounding in Normal and Visual modes
          delete = 'ds',
          find = '',
          find_left = '',
          highlight = '<leader>sH',
          replace = 'cs',

          -- Add this only if you don't want to use extended mappings
          -- suffix_last = '',
          -- suffix_next = '',
        },
        search_method = 'cover_or_next',

        -- Number of lines within which surrounding is searched
        n_lines = 40,
      }

      -- require('mini.animate').setup()

      require('mini.sessions').setup {
        -- Whether to read default session if Neovim opened without file arguments
        autoread = false,

        -- Whether to write currently read session before leaving it
        autowrite = true,

        -- Directory where global sessions are stored (use `''` to disable)
        directory = '~/.nvim_sessions/',

        -- File for local session (use `''` to disable)
        file = 'Session.vim',

        -- Whether to force possibly harmful actions (meaning depends on function)
        force = { read = false, write = false, delete = false },

        -- Hook functions for actions. Default `nil` means 'do nothing'.
        -- Takes table with active session data as argument.
        hooks = {
          -- Before successful action
          pre = { read = nil, write = nil, delete = nil },
          -- After successful action
          post = { read = nil, write = nil, delete = nil },
        },

        -- Whether to print session path after action
        verbose = { read = false, write = true, delete = true },
      } -- replace {} with your config table

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  }, -- END of mini.nvim
  --
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`

  -- [[ END of plugins ]]

  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
} -- END of lazy setup()

-- [[ Extra keybindings (post-plugin loading) by fsimoes ]]
-- Doom-like Oil keymap
vim.keymap.set('n', '<leader>o-', '<cmd>Oil<CR>', { desc = 'Open Oil (file manager)' })

-- Command pickers
vim.keymap.set('n', '<leader>sc', '<cmd>Telescope commands<cr>', { desc = 'Search commands' })
vim.keymap.set('n', '<M-x>', '<cmd>Telescope commands<cr>', { desc = 'Search commands' })
vim.keymap.set('n', '<leader>s:', '<cmd>Telescope command_history<cr>', { desc = 'Search command history' })
vim.keymap.set('n', '<leader>Hc', '<cmd>Telescope command_history<cr>', { desc = 'Search command history' })

-- Doom-like session management
-- vim.keymap.set('n', '<leader>ql', function()
--   vim.ui.input({ prompt = 'Session name: ' }, function(name)
--     if name and name ~= '' then
--       MiniSessions.read(name)
--     end
--   end)
-- end, { desc = 'Load session' })
vim.keymap.set('n', '<leader>ql', function()
  local telescope = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local sessions = vim.tbl_keys(MiniSessions.detected or {})

  telescope
    .new({}, {
      prompt_title = 'Sessions',
      finder = finders.new_table {
        results = sessions,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            MiniSessions.read(selection[1])
          end
        end)
        return true
      end,
    })
    :find()
end, { desc = 'Load session (Telescope)' })

vim.keymap.set('n', '<leader>qw', function()
  MiniSessions.write(nil)
end, { desc = 'Update current session' })

vim.keymap.set('n', '<leader>qn', function()
  vim.ui.input({ prompt = 'New session name: ' }, function(name)
    if name and name ~= '' then
      MiniSessions.write(name)
    end
  end)
end, { desc = 'Create new session' })

-- Keybinding for luasnip
-- vim.keymap.del('i', '<C-k>')
local ls = require 'luasnip'
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump() -- expand or go to next snippet element
  end
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.jumpable(-1) then -- go to previous snippet element
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if ls.choice_active() then
    ls.change_choice(1) -- cycle though list of options
  end
end, { silent = true })

vim.keymap.set('n', '<leader>Sr', '<cmd>source ~/.config/nvim/lua/custom/plugins/luasnip.lua<CR>', { desc = 'Reload LuaSnip' })

-- Colorscheme picker
vim.keymap.set('n', '<leader>sC', '<cmd>Telescope colorscheme<CR>', { desc = 'Search and choose colorscheme' })

-- Toggle dark and light background/mode
vim.api.nvim_create_user_command('ToggleBackground', function()
  vim.o.background = (vim.o.background == 'dark') and 'light' or 'dark'
  vim.cmd.colorscheme(vim.g.colors_name)
end, {})
vim.keymap.set('n', '<leader>tb', function()
  vim.o.background = (vim.o.background == 'dark') and 'light' or 'dark'
  vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = '[T]oggle [B]ackground (light vs dark)' })

-- toggle markdown images in kitty terminal
vim.keymap.set('n', '<leader>ti', function()
  local image = require 'image'
  if image.is_enabled() then
    image.disable()
  else
    image.enable()
  end
end, { desc = 'Toggle images in Markdown (Kitty terminal)' })

-- Orgmode mappings
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'org',
--   callback = function()
--     vim.keymap.set({ 'i', 'n' }, '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
--       silent = true,
--       buffer = true,
--     })
--   end,
-- })
-- TODO: orgmode is still not working how I want it to... so many keybindings missing

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
