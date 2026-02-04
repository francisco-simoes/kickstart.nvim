return {
  'OXY2DEV/markview.nvim',
  config = function()
    require('markview').setup {
      -- preview = { enable = false },
      preview = {
        enable_hybrid_mode = true,

        -- Previews must be enabled in the mode for hybrid to apply.
        modes = { 'n', 'no', 'c', 'i' },

        -- Enable hybrid mode in normal mode (add "i" too if you want it in insert).
        hybrid_modes = { 'n', 'i' },

        -- Make "hybrid" clear by lines (so it can be exactly current line).
        linewise_hybrid_mode = true,

        -- 0,0 => only the current line is treated as “being edited” (so it stays raw).
        edit_range = { 0, 0 },
      },
      markdown = {
        headings = {
          org_indent = true, -- indent sections under headings
          org_shift_width = 2, -- indent per heading level
          org_shift_char = ' ', -- usually " " (spaces)
          org_indent_wrap = true, -- keep wrap support for indented sections
        },
      },

      markdown_inline = {
        checkboxes = {
          enable = true,

          checked = { text = '󰗠', hl = 'MarkviewCheckboxChecked', scope_hl = 'MarkviewCheckboxChecked' },
          unchecked = { text = '󰄰', hl = 'MarkviewCheckboxUnchecked', scope_hl = 'MarkviewCheckboxUnchecked' },

          ['~'] = { text = '󱎖', hl = 'MarkviewCheckboxPending' },
          ['-'] = { text = ' 󱎖', hl = 'MarkviewCheckboxPending', scope_hl = 'MarkviewCheckboxPending' },
          ['='] = { text = ' 󱎖', hl = 'MarkviewCheckboxPending' },
          ['>'] = { text = '', hl = 'MarkviewCheckboxPending' },
          ['}'] = { text = '', hl = 'MarkviewCheckboxPending' },
          ['C'] = { text = '󰍶', hl = 'MarkviewCheckboxCancelled', scope_hl = 'MarkviewCheckboxStriked' },

          ['<'] = { text = '󰃖', hl = 'MarkviewCheckboxCancelled' },
          ['?'] = { text = '󰋗', hl = 'MarkviewCheckboxPending' },
          ['!'] = { text = '󰀦', hl = 'MarkviewCheckboxUnchecked' },
          ['*'] = { text = '󰓎', hl = 'MarkviewCheckboxPending' },
          ['"'] = { text = '󰸥', hl = 'MarkviewCheckboxCancelled' },
          ['l'] = { text = '󰆋', hl = 'MarkviewCheckboxProgress' },
          ['b'] = { text = '󰃀', hl = 'MarkviewCheckboxProgress' },
          ['i'] = { text = '󰰄', hl = 'MarkviewCheckboxChecked' },
          ['S'] = { text = '', hl = 'MarkviewCheckboxChecked' },
          ['I'] = { text = '󰛨', hl = 'MarkviewCheckboxPending' },
          ['p'] = { text = '', hl = 'MarkviewCheckboxChecked' },
          ['c'] = { text = '', hl = 'MarkviewCheckboxUnchecked' },
          ['f'] = { text = '󱠇', hl = 'MarkviewCheckboxUnchecked' },
          ['k'] = { text = '', hl = 'MarkviewCheckboxPending' },
          ['w'] = { text = '', hl = 'MarkviewCheckboxProgress' },
          ['u'] = { text = '󰔵', hl = 'MarkviewCheckboxChecked' },
          ['d'] = { text = '󰔳', hl = 'MarkviewCheckboxUnchecked' },
        },
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
