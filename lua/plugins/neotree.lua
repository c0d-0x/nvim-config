return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim',
    {
      's1n7ax/nvim-window-picker',
      config = function()
        require('window-picker').setup {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
              buftype = { 'terminal', 'quickfix' },
            },
          },
        }
      end,
    },
  },

  config = function()
    --  subtle highlights
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.api.nvim_set_hl(0, 'NeoTreeNormal', { link = 'Normal' })
        vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { link = 'NormalNC' })
        vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', { link = 'WinSeparator' })
        vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { link = 'EndOfBuffer' })
      end,
    })

    --  setup
    require('neo-tree').setup {
      close_if_last_window = false,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
      sort_case_insensitive = false,
      sort_function = nil,

      -- sources
      sources = { 'filesystem' },
      source_selector = {
        winbar = true,
        separator = { left = '', right = '' },
        content_layout = 'center',
        tabs_layout = 'equal',
        sources = {
          { source = 'filesystem', display_name = '󰉓 Files' },
        },
      },

      -- component defaults
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          with_expanders = nil,
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '󰜌',

          default = '*',
          highlight = 'NeoTreeFileIcon',
        },
        modified = {
          symbol = '●',
          highlight = 'NeoTreeModified',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        git_status = {
          symbols = {
            added = '',
            modified = '',
            deleted = '✖',
            renamed = '󰁕',
            untracked = '',
            ignored = '',
            unstaged = '󰄱',
            staged = '󰜵',
            conflict = '󰕚',
          },
        },
        diagnostics = {
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = '󰌶 ',
          },
          highlights = {
            error = 'DiagnosticSignError',
            warn = 'DiagnosticSignWarn',
            info = 'DiagnosticSignInfo',
            hint = 'DiagnosticSignHint',
          },
        },
        file_size = {
          enabled = true,
          required_width = 64,
        },
        type = {
          enabled = true,
          required_width = 122,
        },
        last_modified = {
          enabled = true,
          required_width = 88,
        },
        created = {
          enabled = true,
          required_width = 110,
        },
        symlink_target = {
          enabled = false,
        },
      },

      commands = {},

      window = {
        position = 'left',
        width = 32,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ['<space>'] = { 'toggle_node', nowait = false },
          ['<2-LeftMouse>'] = 'open',
          ['<cr>'] = 'open',
          ['<esc>'] = 'cancel',
          ['P'] = { 'toggle_preview', config = { use_float = true } },
          ['l'] = 'open',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
          ['w'] = 'open_with_window_picker',
          ['C'] = 'close_node',
          ['z'] = 'close_all_nodes',
          ['Z'] = 'expand_all_nodes',
          ['a'] = { 'add', config = { show_path = 'none' } },
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
          ['m'] = 'move',
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
          ['i'] = 'show_file_details',
        },
      },

      nesting_rules = {},

      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
            'node_modules',
            '__pycache__',
            '.virtual_documents',
            '.git',
            '.python-version',
            '.venv',
          },
          hide_by_pattern = {},
          always_show = {},
          never_show = {},
          never_show_by_pattern = {},
        },
        follow_current_file = {
          enabled = false,
          leave_dirs_open = false,
        },
        group_empty_dirs = false,
        hijack_netrw_behavior = 'open_default',
        use_libuv_file_watcher = false,
        commands = {},
      },

      group_empty_dirs = true,
      show_unloaded = true,
    }

    -- keymaps
    vim.cmd [[nnoremap \ :Neotree reveal<cr>]]
    vim.keymap.set('n', '<leader>e', ':Neotree toggle position=left<CR>', { noremap = true, silent = true, desc = 'Toggle file explorer' })
  end,
}
