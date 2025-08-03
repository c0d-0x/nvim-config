return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        direction = 'float',
        float_opts = { border = 'curved', width = 120, height = 30 },
        vim.keymap.set('n', '<M-i>', ':ToggleTerm<CR>', { noremap = true, silent = true }),
      }
    end,
  },
}
