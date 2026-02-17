return {
  'ton/vim-bufsurf',
  init = function()
    vim.keymap.set('n', '<leader>b[', '<Plug>(buf-surf-back)', { silent = true, desc = 'Previous buffer in history' })
    vim.keymap.set('n', '<leader>b]', '<Plug>(buf-surf-forward)', { silent = true, desc = 'Next buffer in history' })
  end,
}
