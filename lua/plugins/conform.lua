return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
    {
      '<leader>tf',
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        if vim.g.disable_autoformat then
          print 'Autoformat on save: OFF'
        else
          print 'Autoformat on save: ON'
        end
      end,
      mode = 'n',
      desc = 'Toggle autoformat on save',
    },
  },

  opts = {
    formatters_by_ft = {
      -- Core
      lua = { 'stylua' },
      python = { 'ruff_format' },
      go = { 'goimports', 'gofmt' },
      rust = { 'rustfmt', sp_format = 'fallback' },

      -- C / C++
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      objc = { 'clang-format' },
      objcpp = { 'clang-format' },
      cuda = { 'clang-format' },
      proto = { 'clang-format' },

      -- JS / TS
      javascript = { 'prettier', stop_after_first = true },
      typescript = { 'prettier', stop_after_first = true },
      tsx = { 'prettier', stop_after_first = true },
      css = { 'prettier', stop_after_first = true },
      html = { 'prettier', stop_after_first = true },
      json = { 'prettier', stop_after_first = true },
      yaml = { 'prettier', stop_after_first = true },
      graphql = { 'prettier', stop_after_first = true },
      prisma = { 'prettier', stop_after_first = true },

      markdown = { 'prettier', stop_after_first = true },
      markdown_inline = { 'prettier', stop_after_first = true },

      bash = { 'shfmt' },
      toml = { 'taplo' },
      dockerfile = { 'hadolint' },
      gitignore = { 'prettier', stop_after_first = true },

      make = { 'checkmake' },
      cmake = { 'cmake_format' },

      vim = { 'vim-format' },
      vimdoc = { 'vimdoc' },
      regex = { 'prettier', stop_after_first = true },

      java = { 'google-java-format' },
      groovy = { 'npm-groovy-lint' },
      sql = { 'sqlfluff' },

      -- Global fallbacks
      ['*'] = { 'codespell', 'textlsp' },
      ['_'] = { 'trim_whitespace' },
    },

    default_format_opts = {
      lsp_format = 'fallback',
    },

    format_on_save = function()
      if vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_fallback = true }
    end,

    formatters = {
      textlsp = {},
      prettier = {
        cli_options = {
          arrow_parens = 'always',
          bracket_spacing = true,
          bracket_same_line = false,
          embedded_language_formatting = 'auto',
          end_of_line = 'lf',
          html_whitespace_sensitivity = 'css',
          jsx_single_quote = true,
          print_width = 120,
          prose_wrap = 'preserve',
          quote_props = 'as-needed',
          semi = true,
          single_attribute_per_line = false,
          single_quote = true,
          tab_width = 2,
          trailing_comma = 'es5',
          use_tabs = false,
          vue_indent_script_and_style = false,
        },
      },

      shfmt = {
        append_args = { '-i', '2' },
      },

      codespell = {
        args = {
          '--write-changes',
          '$FILENAME',
        },
      },
    },
  },

  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
