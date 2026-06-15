-- Настройки сборки для C.
-- Применяются локально к каждому C-буферу.
-- Механизм after/ftplugin исполняет этот файл при каждом открытии фала c filetype=с.

-- Встроенные compiler-плагин vim для gcc выставит правильный errorformat,
-- умеющий разбирать вывод gcc/clang
vim.cmd('compiler gcc')

-- Команда сборки.
-- Если получится найти Makefile, то сборку выполнить через make,
-- иначе компилируется текущий файл через gcc.
local dir = vim.fn.expand('%:p:h')
if vim.fn.filereadable(dir .. '/Makefile') == 1
		or vim.fn.filewritable(dir .. '/makefile') == 1 then
	vim.bo.makeprg = 'make'
else
	-- Для одиночного файла: gcc -o <имя_без_расширения> <файл> с базовыми флагами
	-- %< - имя текущего файла без расширения
	-- % - имя файла
	vim.bo.makeprg = 'gcc -std=c11 -Wall -Wextra -g -o %< %'
end

-- Клавиши для сборки и навигации по ошибкам.
-- buffer = true - маппинги действуют только в этом буфере.
local opts = { buffer = true }

-- Сборка (запустить makeprg, ошибки уйдут в quickfix)
vim.keymap.set('n', '<leader>mb', '<cmd>make<CR>',
	vim.tbl_extend('force', opts, { desc = 'Собрать (make)' }))

-- Открыть/закрыть окно quickfix со списком ошибок.
vim.keymap.set('n', '<leader>mq', '<cmd>copen<CR>',
	vim.tbl_extend('force', opts, { desc = 'Открыть quickfix' }))
