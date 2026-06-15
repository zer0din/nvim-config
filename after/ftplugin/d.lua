-- Настройки сборки для D.
-- Исполняется при октрытии файла с filetype=d.

-- errorformat для dmd/ldc2.
-- Формат ошибок:
-- file(line,col): Level: message
-- Например:
-- source/app.d(5,9): Error: undefined identifier `writl`
-- Нессколько паттернов: с колонкой, без колонки. Прочее игнорируется.
 vim.opt_local.errorformat = {
	'%f(%l\\,%c): %m', -- file(line,col): message
	'%f(%l): %m',      -- file(line): message (без колонки)
 }

-- Команда сборки (dub для проекта, dmd для одиночного файла).
local dir = vim.fn.expand('%:p:h')
-- Поиск маркеров dub-проекта вверх по дерефу от текущего файла.
local dub_root = vim.fs.find(
	{ 'dub.json', 'dub.sdl' },
	{
		path = dir,
		upward = true,
	}
)

-- Если внутри dub-проекта
if #dub_root > 0 then
	vim.bo.makeprg = 'dub build'
else -- Одиночный .d-файл
	-- dmd компилирует и сохраняет собраный файл рядом.
	-- % - имя файла, %< - имя файла без расширения.
	vim.bo.makeprg = 'dmd -of=%< %'
end

-- Назначения клавишь для текущего буфера.
-- Такие же настройки как и для C.
local opts = { buffer = true }

vim.keymap.set('n', '<leader>mb', '<cmd>make<CR>',
	vim.tbl_extend('force', opts, { desc = 'Собрать (make)' }))

vim.keymap.set('n', '<leader>mq', '<cmd>copen<CR>',
	vim.tbl_extend('force', opts, { desc = 'Открыть quickfix' }))
