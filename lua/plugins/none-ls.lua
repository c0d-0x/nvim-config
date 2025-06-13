return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require "null-ls"
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require("mason-null-ls").setup {
      ensure_installed = {
        "asmfmt",
        "asm-lsp",
        "checkmake",
        "checkmake",
        "clangd",
        "clang-format",
        "codespell",
        "css-lsp",
        "dockerls",
        "eslint_d",
        "gofumpt",
        "goimports",
        "gopls",
        "html-lsp",
        "jdtls",
        "lua_lsp",
        "prettier",
        "prettier",
        "prismals",
        "pyright",
        "ruff",
        "rust-analyzer",
        "shfmt",
        "shfmt",
        "sqlfmt",
        "sqlls",
        "sqls",
        "stylua",
        "stylua",
        "typescript-language-server",
      },
      automatic_installation = true,
    }

    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with { filetypes = { "html", "json", "yaml", "markdown" } },
      formatting.stylua,
      formatting.shfmt.with { args = { "-i", "4" } },
      formatting.goimports,
      formatting.gofumpt,
      formatting.clang_format,
      formatting.prettier,
      formatting.asmfmt,
      formatting.sqlfmt,
      diagnostics.checkmake,
      diagnostics.codespell,
      require("none-ls.formatting.ruff").with { extra_args = { "--extend-select", "I" } },
      require "none-ls.formatting.ruff_format",
    }

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}
