return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup {
      theme = 'doom',
      hide = {
        statusline = true,
        tabline = true,
        winbar = true,
      },
      config = {
        vertical_center = true,

        header = {
          '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
          '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
          '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
          '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
          '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
          '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
          '                                                  ',
          '                                                  ',
          '                                                  ',
          '                                                  ',
        },

        center = {
          {
            icon = ' ',
            desc = 'New file',
            key = 'n',
            action = 'enew',
          },
          {
            icon = ' ',
            desc = 'Recent files',
            key = 'r',
            action = 'Telescope oldfiles',
          },
          {
            icon = ' ',
            desc = 'Find file',
            key = 'f',
            action = 'Telescope find_files',
          },
          {
            icon = ' ',
            desc = 'Find text',
            key = 'g',
            action = 'Telescope live_grep',
          },
          {
            icon = ' ',
            desc = 'Config',
            key = 'c',
            action = 'edit $MYVIMRC',
          },
          {
            icon = ' ',
            desc = 'Lazy',
            key = 'l',
            action = 'Lazy',
          },
          {
            icon = ' ',
            desc = 'Mason',
            key = 'm',
            action = 'Mason',
          },
          {
            icon = ' ',
            desc = 'Quit',
            key = 'q',
            action = 'qa',
          },
        },

        footer = {
          '',
          'Neovim ready',
        },
      },
    }
  end,
}
