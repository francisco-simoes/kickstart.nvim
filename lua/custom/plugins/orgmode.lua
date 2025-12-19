return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup {
      org_agenda_files = '~/.orgfiles/**/*',
      org_default_notes_file = '~/.orgfiles/refile.org',

      mappings = { -- NOTE: These are for normal mode!
        ----                For insert mode keymaps: nvim/ftplugin/org.lua
        org = {
          org_meta_return = '<A-CR>', -- add headline, item, etc below
          org_insert_heading_respect_content = '<C-CR>', -- add headline, item, etc below

          org_todo = '<leader>ot', -- cycle forward or open TODO states prompt if enabled
          org_todo_prev = '<leader>oT', -- cycle backward TODO states or open prompt
          org_toggle_checkbox = { '<leader><CR>', '<leader>ox' },

          org_priority_down = { '<leader>pj', '<C-A-j>' },
          org_priority_up = { '<leader>pk', '<C-A-k>' },
          org_priority = { '<leader>p.' },

          org_cycle = { '<TAB>' }, -- Cycle heading folding
          org_global_cycle = { '<S-TAB>' }, -- Cycle global folding
        },
      },

      org_todo_keywords = { 'TODO(t)', 'IDEA(i)', 'INPROGRESS(I)', 'PAUSED(p)', '|', 'DONE(d)', 'CANCELLED(c)' },
      org_todo_keyword_faces = {
        TODO = ':foreground orange :weight bold',
        IDEA = ':foreground yellow',
        INPROGRESS = ':foreground blue',
        PAUSED = ':foreground blue :slant italic',
        DONE = ':foreground green', -- overrides builtin color for `TODO` keyword
        CANCELLED = ':foreground red :slant italic',
      },
      org_startup_folded = 'showeverything',
    }
  end,
}
