return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			themes = {
				"ashen",
				"catppuccin",
				"cyberdream",
				"kanagawa",
				"monochrome",
				"tokyodark",
				"yorumi",
			},

			livePreview = true, -- Apply theme while picking. Default to true.
			vim.keymap.set("n", "<leader>tt", ":Themery<CR>", { noremap = true }),
		})
	end,
}
