-- return {
--   'nanozuki/tabby.nvim',
--   config = function()
--     -- configs...
--   end,
-- }
return {
  'nanozuki/tabby.nvim',
  lazy = false, -- ensure it's loaded so :Tabby exists
  config = function()
    vim.o.showtabline = 1 -- only shows tabline if there are >1 tabs.
    require('tabby').setup { preset = 'tab_only' }
  end,
}
