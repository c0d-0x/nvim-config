require 'core.keymaps'
require 'core.options'
require 'core.snippets'
require 'core.lazy'

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'java', 'cs' },
  callback = function()
    vim.bo.commentstring = '/* %s */'
  end,
})
