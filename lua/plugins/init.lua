-- Управление плагинами через встроенный vim.pack.

-- Список плагинов.
vim.pack.add({
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/nvim-tree/nvim-tree.lua',
	'https://github.com/nvim-tree/nvim-web-devicons', -- иконки для файлов
	'https://github.com/lewis6991/gitsigns.nvim',
})

-- Подключение конфигураций конкретных плагинов.
require('plugins.fzf')
require('plugins.nvim-tree')
require('plugins.gitsigns')
