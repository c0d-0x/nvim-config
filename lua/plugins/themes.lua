return {
	{
		"kdheepak/monochrome.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"ficcdaf/ashen.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style_presets = {
				bold_functions = true,
				italic_comments = true,
			},
		},
	},
	{
		"yorumicolors/yorumi.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				variant = "default",
				transparent = true,
				saturation = 1,
				italic_comments = true,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
		lazy = false,
		priority = 1000,
		opts = { transparent_background = true },
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				theme = {
					wave = {
						ui = {
							float = {
								bg = "none",
							},
						},
					},
				},
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					}
				end,
			})
			vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "none" })
		end,
	},
}
