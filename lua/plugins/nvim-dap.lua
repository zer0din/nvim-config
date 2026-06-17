-- Настройки плагина nvim-dap (для отладки через DAP)
-- В качестве отладчика используется gdb в DAP-режиме (gdb -i dap)

local dap = require('dap')
local dapui = require('dapui')

-- Адаптер.
-- Параметры запуска DAP-сервера плагином
dap.adapters.gdb = {
	type = 'executable',
	command = 'gdb',
	args = { '-i', 'dap' },
}

-- Конфигурация запуска для C.
-- Конфигураций может быть несколько для одного типа файла. Тогда NVim предложит
-- выбрать нужную конфигурацию.
dap.configurations.c = {
	{
		name = 'Запуск (gdb)',
		type = 'gdb', -- ссылка на dap.adapters.gdb (задана выше)
		request = 'launch', -- запустить новый процес, а не подключиться (attach) к существующему
		-- Путь к исполняемому файлу. Определяется при старте отладки.
		-- По умолчанию подставляетстя дирректория + имя файла без расширения,
		-- что соответствует настройкам сборки makerprg (gcc -o %< %) из
		-- after/ftplugin/c.lua
		program = function()
			local default = vim.fn.expand('%:p:r') -- полный путь файла без расширения
			return vim.fn.input('Путь к исполняемому файлу: ', default, 'file')
		end,
		cwd = '${workspaceFolder}',
		stopAtBeginningOfMainSubprogram = false,
	},
}

-- Связка UI с сессией отладки.
-- Панель автоматически открывается при старте отладки и закрывается при завершении.
-- Для реализации этой функциональности нужно прослушивать события dap.
dapui.setup()

dap.listeners.before.attach.dapui_config = function ()
	dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Назначения клавиш
local function map(lhs, rhs, desc)
	vim.keymap.set('n', lhs, rhs, { desc = desc })
end

map('<leader>db', dap.toggle_breakpoint, 'Debug: точка останова')
map('<leader>dc', dap.continue, 'Debug: старт/продолжить')
map('<leader>do', dap.step_over, 'Debug: шаг через')
map('<leader>di', dap.step_into, 'Debug: шаг внутрь')
map('<leader>dO', dap.step_out, 'Debug: шаг наружу')
map('<leader>dt', dap.terminate, 'Debug: завершить сессию')
map('<leader>dr', dap.repl.open, 'Debug: открыть REPL (консоль gdb)')
map('<leader>du', dapui.toggle, 'Debug: переключить панель')

-- Определение значка и цвета для точки останова
vim.fn.sign_define('DapBreakpoint', {
	text = '●',
	texthl = 'DapBreakpoint',
	linehl = '',
	numhl = '',
})
vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e06c75' })  -- красноватый
