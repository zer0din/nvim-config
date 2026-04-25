-- Настройка файлового менеджера nvim-tree.

-- Отключить встроенное дерево netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
	-- Размер и положение
	view = {
		width = 35,
		side = 'left',
	},

	-- Параметры отображения
	renderer = {
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},

--			glyphs = {
--				folder = {
--					arrow_closed = '▸',
--					arrow_open   = '▾',
--					default      = '',
--					open         = '',
--					empty        = '',
--					empty_open   = '',
--					symlink      = '',
--				},
--			},
		},
		-- Подсвечивать открытый в буфере файл
		highlight_opened_files = 'name',
	},

	-- Поведение при открытии файлов.
	actions = {
		open_file = {
			-- Не закрывать дерево при открытии файла.
			quit_on_open = false,
		},
	},

	-- Фильтр отоборажаемых в дереве файлов.
	filters = {
		-- Отображать скрытые файлы (типа .bashrc).
		dotfiles = false,
		-- Скрывать файлы из .gitignore.
		git_ignored = true,
	},

	-- Привязка клавиш внутри буфера дерева (Enter для открытия, a/d/r и т.д.).
	on_attach = function(bufnr)
		-- Привязки по умолчанию.
		local api = require('nvim-tree.api')
		api.config.mappings.default_on_attach(bufnr)
		-- Так же можно задать своим привязки.
		-- Например, Ctrl+t для назначения выбранного каталого корневым.
		vim.keymap.set('n', '<C-t>', api.tree.change_root_to_node, { buffer = bufnr })
	end,
})

-- Привязки клавиш.

-- Открыть/закрыть дерево (<leader>e).
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>',
	{ desc = 'Включить/выключить дерево' })

-- Сфокусироваться на дереве (открыть, если закрыто)
vim.keymap.set('n', '<leader>o', '<cmd>NvimTreeFocus<CR>',
	{ desc = 'Сфокусироваться на файловом дереве' })
