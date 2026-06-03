-- Настройки lau-language-server.
-- https://luals.github.io/wiki/settings/

return {
	-- Команда запуска сервера (имя исполняемого файла в системе)
	cmd = { 'lua-language-server' },
	-- Тип файла для которого он активируется
	filetypes = { 'lua' },
	-- Маркеры корня проекта. Сервер ищет эти файлы ввер по директорям от
	-- открытого файла, чтоб понять где границы проекта.
	root_markers = {
		'.luarc.json',     -- конфиг lua-language-server (если есть)
		'.luarc.jsonc',
		'.stylua.toml',    -- конфиг форматтера StyLua
		'stylua.toml',
		'.git',
	},
	-- Настройки самого lua-language-server
	settings = {
		Lua = {
			-- Версия Lua.
			runtime = {
				-- nvim использует LuaJIT для своего API
				version = 'LuaJIT',
			},
			-- Подсказки и проверк
			diagnostics = {
				-- vim устанавливается глобальной переменной, чтоб небыло
				-- предупреждения "undefined global vim"
				globals = { 'vim' },
			},
			-- Доступные библиотеки. Сервер должен знать про vim.api, vim.opt, vim.fn и т.д.
			workspaces = {
				-- Указание ратнайм-файлов nvim, там определены все vim.*
				library = vim.api.nvim_get_runtime_file('', true),
				-- При больших проектах сервер может спрашивать "scan all files?".
				-- Отключить сторонний библиотечный сканер, чтоб не спрашивал.
				checkThirdParty = false,
			},
			-- Отключение телеметрии
			telemetry = {
				enable = false,
			},
		},
	},
}
