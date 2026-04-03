return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require 'telescope.actions'
    local builtin = require 'telescope.builtin'
    local themes = require 'telescope.themes'

    require('telescope').setup {
      defaults = {
        prompt_prefix = '   ',
        selection_caret = ' ',
        entry_prefix = '  ',
        multi_icon = ' ',

        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.45,
          },
          width = 0.87,
          height = 0.80,
        },

        path_display = { 'truncate' },
        file_ignore_patterns = { 'node_modules', '%.git/', '%.venv/' },

        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-l>'] = actions.select_default,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<esc>'] = actions.close,
          },
          n = {
            ['q'] = actions.close,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },

      pickers = {
        find_files = {
          hidden = true,
          file_ignore_patterns = { 'node_modules', '%.git/', '%.venv/' },
        },
        live_grep = {
          additional_args = { '--hidden' },
          file_ignore_patterns = { 'node_modules', '%.git/', '%.venv/' },
        },
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
          mappings = {
            i = { ['<C-x>'] = actions.delete_buffer },
            n = { ['dd'] = actions.delete_buffer },
          },
        },
        git_commits = { previewer = true },
        git_status = { previewer = true },
        diagnostics = { theme = 'ivy' },
        oldfiles = { previewer = false },
      },

      extensions = {
        ['ui-select'] = {
          themes.get_dropdown(),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    }

    -- extensions
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- KEYMAPS
    -- Search
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = '[S]earch Recent Files' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Git
    vim.keymap.set('n', '<leader>sgc', builtin.git_commits, { desc = '[S]earch [G]it [C]ommits' })
    vim.keymap.set('n', '<leader>sgs', builtin.git_status, { desc = '[S]earch [G]it [S]tatus' })
    vim.keymap.set('n', '<leader>sgb', builtin.git_branches, { desc = '[S]earch [G]it [B]ranches' })

    -- Current buffer fuzzy find (dropdown, no preview)
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown {
        winblend = 0,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Live grep across open buffers only
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })
  end,
}
