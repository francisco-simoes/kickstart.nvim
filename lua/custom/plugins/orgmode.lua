return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup {
      org_agenda_files = {
        '~/.orgfiles/**/*',
        '~/Documents/Notes/general_todos.org',
        '~/Documents/Notes/Career/**/*',
        '~/Documents/Notes/postdoc_todos.org',
        '~/Documents/Notes/Readings/reading_list.org',
      },
      org_default_notes_file = '~/.orgfiles/refile.org',
      -- org_adapt_indentation = true, -- indent subheadings etc
      org_startup_indented = true,
      -- org_id_link_to_org_use_id = true,

      mappings = { -- NOTE: These are for normal mode!
        ----                For insert mode keymaps: nvim/ftplugin/org.lua
        org = {
          org_meta_return = '<A-CR>', -- add headline, item, etc below
          org_insert_heading_respect_content = '<C-CR>', -- add headline, item, etc below

          org_todo = '<leader>oT', -- cycle forward or open TODO states prompt if enabled
          -- org_todo_prev = '', -- cycle backward TODO states or open prompt

          org_deadline = '<leader>odd',
          org_schedule = '<leader>ods',

          org_set_tags_command = '<leader>og',

          org_toggle_checkbox = { '<leader><CR>', '<leader>ox' },

          org_priority_down = { '<leader>pj', '<C-A-j>' },
          org_priority_up = { '<leader>pk', '<C-A-k>' },
          org_priority = { '<leader>p.' },

          org_cycle = { '<TAB>' }, -- Cycle heading folding
          org_global_cycle = { '<S-TAB>' }, -- Cycle global folding
        },
      },

      org_todo_keywords = { 'TODO(t)', 'IDEA(i)', 'INPROGRESS(m)', 'RECURRENT(r)', '|', 'DONE(d)', 'CANCELLED(c)', 'PARTIAL(h)', 'PAUSED(p)' },
      org_todo_keyword_faces = {
        TODO = ':foreground orange :weight bold',
        IDEA = ':foreground orange',
        INPROGRESS = ':foreground blue',
        PAUSED = ':foreground blue :slant italic',
        RECURRENT = ':foreground darkorange :slant italic',
        DONE = ':foreground green', -- overrides builtin color for `TODO` keyword
        CANCELLED = ':foreground red :slant italic',
        PARTIAL = ':foreground green',
      },
      org_startup_folded = 'showeverything',
      win_split_mode = { 'float', 0.8 },
    }
    -- better org agenda scheduled items color
    vim.api.nvim_set_hl(0, '@org.agenda.scheduled', { fg = '#ff0000' })
  end,
}
