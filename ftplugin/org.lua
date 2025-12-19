-- NOTE: The normal mode keymaps of the orgmode plugin are defined in the plugin's config.
--       We add here some similar insert mode keymaps.

vim.keymap.set('i', '<C-CR>', function()
  require('orgmode').action 'org_mappings.insert_heading_respect_content'
end, { buffer = true, silent = true })

vim.keymap.set('i', '<A-CR>', function()
  require('orgmode').action 'org_mappings.meta_return'
end, { buffer = true, silent = true })

vim.keymap.set('i', '<C-A-j>', function()
  require('orgmode').action 'org_mappings.priority_down'
end, { buffer = true, silent = true })

vim.keymap.set('i', '<C-A-k>', function()
  require('orgmode').action 'org_mappings.priority_up'
end, { buffer = true, silent = true })
