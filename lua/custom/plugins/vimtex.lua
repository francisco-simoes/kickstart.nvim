return {
  'lervag/vimtex',
  enabled = true,
  lazy = false, -- we should NOT lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_complete_enabled = 1
    vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2 -- >0 for errors to not distract
    vim.g.vimtex_quickfix_open_on_warning = 0
    -- vim.g.maplocalleader = ','
  end,
}
