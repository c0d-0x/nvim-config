return {
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Old text                    Command         New text
        --------------------------------------------------------------------------------
        -- surr*ound_words             ysiw)           (surround_words)
        -- *make strings               ys$"            "make strings"
        -- [delete ar*ound me!]        ds]             delete around me!
        -- remove <b>HTML t*ags</b>    dst             remove HTML tags
        -- 'change quot*es'            cs'"            "change quotes"
        -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
        -- delete(functi*on calls)     dsf             function calls
      }
    end,
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
    config = function() end,
  },
  {
    --Cursor animations
    'sphamba/smear-cursor.nvim',
    opts = {
      legacy_computing_symbols_support = true,
      cursor_color = '#ff8800',
      stiffness = 0.6,
      trailing_stiffness = 0.1,
      trailing_exponent = 5,
      never_draw_over_target = true,
      hide_target_hack = true,
      gamma = 1,
    },
  },
  {
    -- Tmux & split window navigation
    'christoomey/vim-tmux-navigator',
  },
  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup {
        render = 'virtual',
        virtual_symbol = ' ',
      }
    end,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup {
        -- "modern", "classic", "minimal", "powerline",
        -- "ghost"
        preset = 'ghost',
      }
      vim.diagnostic.config { virtual_text = false }
    end,
  },
}
