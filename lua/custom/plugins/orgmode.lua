return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup {
      org_agenda_files = '~/.orgfiles/**/*',
      org_default_notes_file = '~/.orgfiles/refile.org',

      org_todo_keywords = { 'TODO(t)', 'IDEA(i)', '|', 'DONE(d)', 'CANCELLED(c)' },
      org_todo_keyword_faces = {
        TODO = ':foreground orange :weight bold',
        IDEA = ':foreground yellow',
        DONE = ':foreground green', -- overrides builtin color for `TODO` keyword
        CANCELLED = ':foreground red :slant italic',
      },
      org_startup_folded = 'showeverything',
    }
  end,
}
