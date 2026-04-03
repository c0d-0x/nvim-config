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
  {
    {
      'tiagovla/tokyodark.nvim',
      opts = {
        -- custom options here
      },
      config = function(_, opts)
        require('tokyodark').setup(opts) -- calling setup is optional
      end,
    },
  },
  {
    'AstroNvim/astrotheme',
    lazy = false,
    priority = 1000,
    config = function()
      require('astrotheme').setup {
        style = {
          transparent = false,
          inactive = true,
          float = true,
          neotree = true,
          border = true,
          title_invert = true,
          italic_comments = true,
          simple_syntax_colors = true,
        },
      }
    end,
  },
  {
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        themes = {
          'astrodark',
          'astrolight',
          'catppuccin',
          'cyberdream',
          'monochrome',
          'tokyodark',
          'yorumi',
        },

        livePreview = true,
        vim.keymap.set('n', '<leader>tt', ':Themery<CR>', { noremap = true }),
      }
    end,
  },
}
