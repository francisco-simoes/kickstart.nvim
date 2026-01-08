return {
  'OXY2DEV/markview.nvim',
  config = function()
    require('markview').setup {
      preview = { enable = false },
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.keymap.set('n', '<leader>m', ":echo 'Markdown only'<CR>", {
          silent = true,
        })
        vim.keymap.set('n', '<leader>tm', '<CMD>Markview<CR>', {
          buffer = true, -- only applies to current buffer
          desc = 'Toggles `markview` previews.',
        })
      end,
    })
  end,
}
