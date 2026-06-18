-- Настройка сборки для PlayDate проектов.
-- Данный файл исполняется для любого буфера с открытым .lua-файлом,
-- но на данный момент предназначен только для настройки сборки для PlayDate.
-- Для этого сначала проверяется наличие pdxinfo в корне проекта и только потом
-- настраивается сборка при помощи pdc (PlayDate Compiler).

-- Попытаться найти pdxinfo вверх по дереву от текущего файла
local pdxinfo = vim.fs.find('pdxinfo',
	{
		path = vim.fn.expand('%:p:h'),
		upward = true,
	})

-- Если это не PlayDate-проект, то выйти ни чего не настраивая
if #pdxinfo == 0 then
	return
end

-- Директория исходников проекта (pdxinfo лежит в корневой директории исходников).
local sources_dir = vim.fs.dirname(pdxinfo[1])

-- Корневая директория проекта (в которой находится уже сама директория с исходниками).
local project_root = vim.fs.dirname(sources_dir)

-- Имя проекта (корневой каталог) для имени файла готовой сборки (.pdx).
local project_name = vim.fs.basename(project_root)

-- Каталог для сборки
local build_dir = project_root .. '/build'

-- Выходной путь для сборки (<корень>/build/<имя_проекта>.pdx)
-- Каталог build не создается автоматически (должен быть создан вручную)
local output = build_dir .. '/' .. project_name .. '.pdx'

-- Настройки makeprg (pdc <каталог_исходников> <результат>.pdx)
vim.bo.makeprg = 'pdc ' .. sources_dir .. ' ' .. output

-- Формат ошибок pdc: "error: <файл>:<строка>: <сообщение>"
-- %f - файл, %1 - строка, %, - сообщение. Колонку pdc не указывает.
vim.bo.errorformat = 'error: %f:%l: %m'

-- Привязки клавиш
local opts = { buffer = true }

vim.keymap.set('n', '<leader>mb',
	function()
		vim.fn.mkdir(build_dir, 'p')
		vim.cmd.make()
	end,
	vim.tbl_extend('force', opts, { desc = 'Собрать .pdx (PlayDate)' }))

vim.keymap.set('n', '<leader>mq', '<cmd>copen<CR>',
	vim.tbl_extend('force', opts, { desc = 'Открыть quickfix' }))

vim.keymap.set('n', '<leader>mr',
	function()
		vim.system({ 'PlaydateSimulator', output })
	end,
	vim.tbl_extend('force', opts, { desc = 'Запустить в симуляторе PlayDate' }))
