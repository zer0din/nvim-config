-- Управление плагинами через встроенный vim.pack.

-- Список плагинов.
vim.pack.add({
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/nvim-tree/nvim-tree.lua',
	'https://github.com/nvim-tree/nvim-web-devicons', -- иконки для файлов
	'https://github.com/lewis6991/gitsigns.nvim',
	-- Плагины для работы dap (nvim-dap)
	'https://github.com/mfussenegger/nvim-dap',
	'https://github.com/nvim-neotest/nvim-nio', -- завиисимость для nvim-dap-ui
	'https://github.com/rcarriga/nvim-dap-ui',  -- ui для nvim-dap
})

-- Подключение конфигураций конкретных плагинов.
require('plugins.fzf')
require('plugins.nvim-tree')
require('plugins.gitsigns')
require('plugins.nvim-dap')
