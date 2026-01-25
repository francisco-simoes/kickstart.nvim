return {
  'bullets-vim/bullets.vim', -- Powerful for list stuff in markdown files!
  config = function()
    vim.g.bullets_enabled_file_types = {
      'markdown',
      'text',
    }
  end,
}
