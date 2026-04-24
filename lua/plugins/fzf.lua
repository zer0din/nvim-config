-- Настройка fzf-lua (fuzzy-finder).
-- Использует внешние утилиты fzf, ripgrep, fd.

local fzf = require('fzf-lua')

-- Настройки окна. Больше для примера, т.к. базовых настроек хватает.
fzf.setup({
	winopts = {
		-- Размер плавающего окна относительно основного.
		height = 0.85,
		width = 0.85,
		-- Рамка вокруг окна.
		border = 'rounded',
		-- Разделение на список результатов и предпросмотр.
		preview = {
			layout = 'vertical',
			vertical = 'down:50%',
		},
	},
})

-- Привязки клавиш.
-- Префикс <leader>f - от "find".

vim.keymap.set('n', '<leader>ff', fzf.files,
	{ desc = 'Найти файл в проекте' })

vim.keymap.set('n', '<leader>fg', fzf.live_grep,
	{ desc = 'Поиск текста в проекте (ripgrep)' })

vim.keymap.set('n', '<leader>fb', fzf.buffers,
	{ desc = 'Переключение между открытыми буферами' })

vim.keymap.set('n', '<leader>fh', fzf.helptags,
	{ desc = 'Поиск по справке nvim' })

vim.keymap.set('n', '<leader>fr', fzf.oldfiles,
	{ desc = 'Недавно открытые файлы' })
