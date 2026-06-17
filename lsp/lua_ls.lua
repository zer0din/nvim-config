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
	-- Настройки самого lua-language-server.
	-- Только для нейтрального окружения.
	-- Особенности для разных проектов нужно задать в .luarc.json.
	-- Например, для NeoVim в директории .config/nvim, или для проектов
	-- Love2D и PlayDate в своих директория со своми параметрами.
	settings = {
		Lua = {
			-- Отключить сторонний библиотечный сканер, чтоб не спрашивал.
			workspace = { checkThirdParty = false },
			-- Отключение телеметрии.
			telemetry = { enable = false },
		},
	},
}
