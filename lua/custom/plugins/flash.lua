return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  -- ---@type Flash.Config
  opts = {},
  keys = {
    {
      's',
      mode = { 'n', 'x' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'gs', -- free up s for surround in operator-pending mode
      mode = { 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },

    {
      'gS', -- free up S for surround in all modes
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-f>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
