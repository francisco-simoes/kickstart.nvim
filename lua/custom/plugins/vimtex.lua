return {
  'lervag/vimtex',
  enabled = false,
  lazy = false, -- we should NOT lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_complete_enabled = 1
    -- vim.g.maplocalleader = ','
  end,
}
