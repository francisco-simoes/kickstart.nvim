-- Just to test a autosnippet for now!!
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node

local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  ls.add_snippets('lua', {
    s('hello', {
      t "print('hello world')",
    }),
  }),
}
