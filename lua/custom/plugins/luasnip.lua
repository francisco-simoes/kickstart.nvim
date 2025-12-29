return {
  'L3MON4D3/LuaSnip',
  version = '2.*',
  event = 'InsertEnter',
  config = function()
    -- local ls = require 'luasnip'
    -- local types = require 'luasnip.util.types'
    require('luasnip').config.set_config {
      history = true,
      enable_autosnippets = true,
      updateevents = 'TextChanged,TextChangedI',
    }
    require('luasnip.loaders.from_lua').lazy_load { paths = vim.fn.stdpath 'config' .. '/lua/custom/plugins/luasnip' }
    -- require('luasnip.loaders.from_lua').load { paths = vim.fn.stdpath 'config' .. '/lua/custom/plugins/luasnip' }
    -- require(vim.fn.stdpath 'config' .. '/lua/custom/plugins/luasnip/test.lua')
    --
    --
  end,
  -- build = (function()
  --   -- Build Step is needed for regex support in snippets.
  --   -- This step is not supported in many windows environments.
  --   -- Remove the below condition to re-enable on windows.
  --   if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
  --     return
  --   end
  --   return 'make install_jsregexp'
  -- end)(),
  dependencies = {
    -- `friendly-snippets` contains a variety of premade snippets.
    --    See the README about individual language/framework/plugin snippets:
    --    https://github.com/rafamadriz/friendly-snippets
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load { exclude = { 'javascript' } }
      end,
    },
  },
  -- opts = { enable_autosnippets = true },

  -- ls.config.set_config {
  --   history = true, -- keep around the last snippet
  --   updateevents = 'TextChanged,TextChangedI', -- for dynamic snippets
  --   enable_autosnippets = true,
  -- },
}
