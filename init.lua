require "core.keymaps"
require "core.options"
require "core.snippets"
require "core.lazy"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "java", "h", "cs" },
  callback = function()
    vim.bo.commentstring = "/* %s */"
  end,
})
