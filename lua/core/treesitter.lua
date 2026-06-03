-- Встроенная подсветка treesitter

local group = vim.api.nvim_create_augroup('CoreTreesitter', { clear = true })

-- Включить treesitter-подсветку при определении плагинга.
-- Если парсера для языка нет, то включится обычная regex-подсветка.
vim.api.nvim_create_autocmd('FileType', {
	group = group,
	desc = 'Включить treesitter-подсветку при наличии парсера',
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf)
	end,
})
