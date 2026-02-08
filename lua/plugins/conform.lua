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
    -- Define your formatters
    formatters_by_ft = {
      -- Core
      lua = { 'stylua' },
      python = { 'ruff_format' },
      go = { 'goimports', 'gofmt' },
      rust = { 'rustfmt' },

      -- C / C++
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      objc = { 'clang-format' },
      objcpp = { 'clang-format' },
      cuda = { 'clang-format' },
      proto = { 'clang-format' },

      -- JS / TS
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      tsx = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      graphql = { 'prettierd', 'prettier', stop_after_first = true },
      prisma = { 'prettierd', 'prettier', stop_after_first = true },

      -- Docs
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      markdown_inline = { 'prettierd', 'prettier', stop_after_first = true },

      -- Shell / Config
      bash = { 'shfmt' },
      toml = { 'taplo' },
      dockerfile = { 'hadolint' },
      gitignore = { 'prettierd', 'prettier', stop_after_first = true },

      -- Build systems
      make = { 'checkmake' },
      cmake = { 'cmake_format' },

      -- Editors / misc
      vim = { 'vim-format' },
      vimdoc = { 'vimdoc' },
      regex = { 'prettierd', 'prettier', stop_after_first = true },

      -- Backend / enterprise
      java = { 'google-java-format' },
      groovy = { 'npm-groovy-lint' },
      sql = { 'sqlfluff' },

      -- Global fallbacks
      ['*'] = { 'codespell' },
      ['_'] = { 'trim_whitespace' },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = 'fallback',
    },
    -- Set up format-on-save
    format_on_save = function()
      if vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    -- Customize formatters
    formatters = {
      shfmt = {
        append_args = { '-i', '2' },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
