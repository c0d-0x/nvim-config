return {
  'zaldih/themery.nvim',
  lazy = false,
  config = function()
    require('themery').setup {
      themes = {
        'catppuccin',
        'cyberdream',
        'monochrome',
        'tokyonight',
        'oxocarbon',
        'yorumi',
      },

      livePreview = true,
      vim.keymap.set('n', '<leader>tt', ':Themery<CR>', { noremap = true }),
    }
  end,
}
