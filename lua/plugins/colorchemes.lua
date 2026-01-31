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
  { 'bluz71/vim-moonfly-colors', name = 'moonfly', lazy = false, priority = 1000 },
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
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        themes = {
          'catppuccin',
          'cyberdream',
          'monochrome',
          'moonfly',
          'tokyodark',
          'yorumi',
        },

        livePreview = true,
        vim.keymap.set('n', '<leader>tt', ':Themery<CR>', { noremap = true }),
      }
    end,
  },
}
