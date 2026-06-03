-- Настройки serve-d - language server для языка D.
-- https://github.com/Pure-D/serve-d

return {
	-- Команда запуска.
	cmd = { 'serve-d' },
	-- Для какого типа файлов.
	filetype = { 'd' },
	-- Маркер корня проекта. serve-d завязан на dub, по этому в проекту должны
	-- присутствовать dub.json или dub.sdl.
	root_markers = {
		'dub.json',
		'dub.sdl',
		'dub.selections.json',
		'.git',
	},
}
