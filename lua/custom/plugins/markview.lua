return {
  'OXY2DEV/markview.nvim',
  config = function()
    require('markview').setup {
      -- preview = { enable = false },
      preview = {
        enable_hybrid_mode = true,

        -- Previews must be enabled in the mode for hybrid to apply.
        modes = { 'n', 'no', 'c' },

        -- Enable hybrid mode in normal mode (add "i" too if you want it in insert).
        hybrid_modes = { 'n' },

        -- Make "hybrid" clear by lines (so it can be exactly current line).
        linewise_hybrid_mode = true,

        -- 0,0 => only the current line is treated as “being edited” (so it stays raw).
        edit_range = { 0, 0 },
      },
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        -- vim.keymap.set('n', '<leader>m', ":echo 'Markdown only'<CR>", {
        --   silent = true,
        -- })
        vim.keymap.set('n', '<leader>tm', '<CMD>Markview<CR>', {
          buffer = true, -- only applies to current buffer
          desc = 'Toggles `markview` previews.',
        })
      end,
    })
  end,
}
