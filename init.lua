require 'core.keymaps'
require 'core.options'
require 'core.snippets'
require 'core.lazy'

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'java', 'h', 'cs', 'go' },
  callback = function()
    vim.bo.commentstring = '/* %s */'
  end,
})

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
