return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = {
      char = '▏',
    },
    scope = {
      show_start = true,
      show_end = true,
      show_exact_scope = true,
    },
    exclude = {
      filetypes = {
        'dashboard',
        'help',
        'neogitstatus',
        'NvimTree',
        'packer',
        'startify',
        'themery',
        'Trouble',
      },
    },
  },
}
