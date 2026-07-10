return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local function fg(name)
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      local color = hl and (hl.fg or hl.foreground)
      return color and { fg = string.format('#%06x', color) } or nil
    end

    local mode = {
      'mode',
      fmt = function(str)
        local icons = {
          NORMAL = '󰋜',
          INSERT = '󰏫',
          VISUAL = '󰈈',
          ['V-LINE'] = '󰈈',
          ['V-BLOCK'] = '󰈈',
          REPLACE = '󰛔',
          COMMAND = '󰘳',
          TERMINAL = '',
        }
        local icon = icons[str] or ''
        return icon .. ' ' .. str
      end,
      padding = { left = 1, right = 1 },
    }

    local filename = {
      'filename',
      file_status = true,
      path = 0,
      symbols = {
        modified = '●',
        readonly = '',
        unnamed = '󰡯 No Name',
        newfile = '󰝒 New',
      },
    }

    local branch = {
      'branch',
      icon = '',
    }

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = true,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = true,
      symbols = { added = ' ', modified = ' ', removed = ' ' },
      diff_color = {
        added = fg 'GitSignsAdd' or { fg = '#98be65' },
        modified = fg 'GitSignsChange' or { fg = '#ecbe7b' },
        removed = fg 'GitSignsDelete' or { fg = '#ec5f67' },
      },
      cond = hide_in_width,
    }

    local lsp_status = {
      function()
        local clients = vim.lsp.get_clients { bufnr = 0 }
        if #clients == 0 then
          return '󰅚 No LSP'
        end
        local names = {}
        for _, c in ipairs(clients) do
          table.insert(names, c.name)
        end
        return '󰒍 ' .. table.concat(names, ', ')
      end,
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree' },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = { filename },
        lualine_x = {
          lsp_status,
          diagnostics,
          diff,
          { 'encoding', cond = hide_in_width },
          { 'filetype', colored = true, cond = hide_in_width },
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive', 'lazy', 'mason', 'neo-tree', 'trouble' },
    }
  end,
}
