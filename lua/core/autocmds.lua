-- Автокоманды реагирующие на события редактора.

-- Автокоманды определяются в группу, которая очищается при повторной загрузке
-- конфига. Это позволяет избежать дублирования команд.
local core_group = vim.api.nvim_create_augroup('CoreAutocmds', { clear = true })

-- Подстветка скопированного текста (при помощи y, yy, yiw и т.д.).
vim.api.nvim_create_autocmd('TextYankPost', {
  group = core_group,
  desc = 'Подсветка скопированного текста',
  callback = function()
    vim.hl.on_yank({ timeout = 150 }) -- задержка для подстветки
  end,
})

-- Восстановление позиции курсора при повторном открытии файла
vim.api.nvim_create_autocmd('BufReadPost', {
	group = core_group,
	desc = 'Восстановление позиции курсора, при повторном открытии файла',
	callback = function(ev)
		local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(ev.buf)
		local file_type = vim.bo[ev.buf].filetype
		if mark[1] > 0 and mark[1] <= line_count
				and file_type ~= 'gitcommit'
				and file_type ~= 'gitrebase' then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end
})

-- Перенос строк и проверка орфографии для текстовых и markdown-файлов.
vim.api.nvim_create_autocmd('FileType', {
	group = core_group,
	pattern = { 'text', 'markdown', 'gitcommit' },
	desc = 'Перенос строк и проверка орфографии для текстовых и markdown-файлов',
	callback = function()
		-- Настройки применяются локально, только для буфера в котором открыт файл
		vim.opt_local.wrap = true                   -- перенос строк
		vim.opt_local.linebreak = true              -- не разрывать слова при переносе
		vim.opt_local.spell = true                  -- проверка орфографии
		vim.opt_local.spelllang = { 'ru', 'en_us' } -- словари (будут загружены автоматически)
	end
})
