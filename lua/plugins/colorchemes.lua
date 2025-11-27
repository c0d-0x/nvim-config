return {
  {
    'kdheepak/monochrome.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'yorumicolors/yorumi.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        variant = 'default',
        transparent = true,
        saturation = 1,
        italic_comments = true,
      }
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
        float = {
          transparent = true,
          solid = false,
        },
      }
    end,
  },
}
