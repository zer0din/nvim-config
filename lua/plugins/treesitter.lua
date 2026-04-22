-- Настройки плагина nvim-treesitter.

require('nvim-treesitter.configs').setup({
	-- Необходимые парсеры, которые обязательно должны установиться
	ensure_installed = {
		'bash',
		'lua',
		'luadoc',          -- для ---@... комментариев в Lua
		'markdown',
		'markdown_inline', -- для inline-конструкций внутри markdown
	},

	-- Автоматическая установка парсеров при открытии файлов. Отключена.
	auto_install = false,

	-- Синхронная инсталяция парсеров будет отключеня. Т.е. они будут
	-- устанавливаться в фонет. Эта опция касается только парсеров из ensure_installed.
	sync_install = false,

	-- Посветка средствами treesitter включена.
	highlight = {
		enable = true,
		-- не зайдействовать подстветку nvim, при задействованной treesitter.
		additional_vim_regex_highlighting = false,
	},

	-- Отступы не расствляются при помощи treesitter.
	indent = {
		enable = false,
	},
})
