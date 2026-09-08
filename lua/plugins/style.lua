return {
  {
    'maxmx03/fluoromachine.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local fm = require 'fluoromachine'

      fm.setup {
        glow = false,
        theme = 'fluoromachine', -- fluoromachine retrowave delta
        transparent = true,

        colors = function(_, color)
          local darken = color.darken
          return {
            bg = '#000000',
            bgdark = darken('#000000', 20),
          }
        end,
        overrides = {
          ['@type'] = { italic = true },
          ['@function'] = { italic = false, bold = false },
          ['@comment'] = { italic = true },
          ['@keyword'] = { italic = false },
          ['@constant'] = { italic = false, bold = false },
          ['@variable'] = { italic = true },
          ['@field'] = { italic = true },
          ['@parameter'] = { italic = true },
        },
      }
    end,
  },
  {
    'wtfox/luna.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      accent = 1.0,
      plugins = {
        all = true,
        auto = true,
      },
    },
  },
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
        transparent_background = true,
        gamma = 1.00, -- adjust brightness
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          identifiers = { italic = true },
          functions = { italic = true },
          variables = { italic = true },
        },
      },
      config = function(_, opts)
        require('tokyodark').setup(opts)
      end,
    },
  },
  {
    'ember-theme/nvim',
    name = 'ember',
    priority = 1000,
    config = function()
      require('ember').setup {
        variant = 'ember-soft', -- "ember", "ember-soft", "ember-light"
        styles = {
          comments = { italic = true },
          keywords = { bold = true },
          functions = { italic = true },
          types = { bold = true },
        },
        transparent = false,
      }
    end,
  },
  {
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        themes = {
          'catppuccin',
          'cyberdream',
          'ember',
          'ember-light',
          'fluoromachine',
          'luna',
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
