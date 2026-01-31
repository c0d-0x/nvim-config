-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '▎' }, -- U+258E
      change = { text = '▎' },
      delete = { text = '' }, -- nf-fa-caret_right
      topdelete = { text = '' },
      changedelete = { text = '▎' },
    },

    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
    },
  },
}
