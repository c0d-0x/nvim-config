return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'hrsh7th/cmp-nvim-lsp',
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = { winblend = 0 },
        },
      },
    },
  },
  config = function()
    -- on attach
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local tb = require 'telescope.builtin'

        -- Navigation
        map('gd', tb.lsp_definitions, '[G]oto [D]efinition')
        map('gr', tb.lsp_references, '[G]oto [R]eferences')
        map('gI', tb.lsp_implementations, '[G]oto [I]mplementation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>D', tb.lsp_type_definitions, 'Type [D]efinition')

        -- Symbols
        map('<leader>ds', tb.lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', tb.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Actions
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Document highlight on cursor hold
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(ev)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = ev.buf }
            end,
          })
        end

        -- Inlay hints toggle
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end

        -- Signature help in insert mode
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
          map('<C-x>', vim.lsp.buf.signature_help, 'Signature Help', 'i')
        end
      end,
    })

    local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      ruff = {},
      pyright = {},
      dockerls = {},
      yamlls = {},
      jsonls = {},
      goimports = {},
      jdtls = {},
      prismals = {},
      hyprls = {},
      codespell = {},

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

      gopls = {
        settings = {
          gopls = {
            staticcheck = true,
            gofumpt = true,
          },
        },
      },

      bashls = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh' },
        settings = {
          bashIde = {
            globPattern = '*@(.sh|.inc|.bash|.command)',
          },
        },
      },

      asm_lsp = {
        filetypes = { 'asm', 's', 'S', 'ASM' },
      },

      cssls = {
        filetypes = { 'css', 'scss', 'less' },
      },

      checkmake = {
        filetypes = { 'make', 'makefile' },
      },

      clangd = {
        filetypes = { 'c', 'cpp' },
        init_options = {
          fallbackFlags = { '-std=c17' },
        },
      },

      ts_ls = {},

      html = {
        filetypes = { 'html', 'css', 'twig', 'hbs' },
        init_options = {
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
        },
      },

      sqlls = {
        filetypes = { 'sql', 'mysql' },
      },

      textlsp = {
        analysers = {
          languagetool = {
            enabled = true,
            check_text = {
              on_open = true,
              on_save = true,
              on_change = false,
            },
          },
        },
        documents = {
          language = 'auto:gb',
          -- do not autodetect documents with fewer characters
          min_length_language_detect = 20,
          org = {
            org_todo_keywords = {
              'TODO',
              'IN_PROGRESS',
              'DONE',
            },
          },
          txt = {
            parse = true,
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            diagnostics = { disable = { 'missing-fields' }, globals = { 'vim' } },
            format = { enable = false },
          },
        },
      },
    }

    -- mason install + enable
    require('mason-tool-installer').setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    for server, conf in pairs(servers) do
      conf.capabilities = vim.tbl_deep_extend('force', {}, capabilities, conf.capabilities or {})
      vim.lsp.config(server, conf)
      vim.lsp.enable(server)
    end
  end,
}
