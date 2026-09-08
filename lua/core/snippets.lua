vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

-- Appearance of diagnostics
vim.diagnostic.config {
  virtual_text = {
    spacing = 3,
    prefix = '●',

    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌵 ',
    },
  },
  severity_sort = true,
  underline = { severity = vim.diagnostic.severity.ERROR },

  update_in_insert = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },

  on_ready = function()
    vim.cmd 'highlight DiagnosticVirtualText guibg=NONE'
  end,
}

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore last cursor position',
  callback = function()
    if vim.o.diff then
      return
    end

    local last_pos = vim.api.nvim_buf_get_mark(0, '"')
    local last_line = vim.api.nvim_buf_line_count(0)

    local row = last_pos[1]
    if row < 1 or row > last_line then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  end,
})

-- Help window in a vertical split
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  command = 'wincmd L',
})

-- Auto delete 'No Name' empty buffers
vim.api.nvim_create_autocmd('BufHidden', {
  desc = 'Auto-delete empty unnamed buffers',
  callback = function(args)
    local buf = args.buf
    if
      vim.api.nvim_buf_get_name(buf) == ''
      and vim.bo[buf].buftype == ''
      and not vim.bo[buf].modified
      and #vim.api.nvim_buf_get_lines(buf, 0, -1, false) <= 1
      and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ''
    then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
          pcall(vim.api.nvim_buf_delete, buf, { force = false })
        end
      end)
    end
  end,
})
