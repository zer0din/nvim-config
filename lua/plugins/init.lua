-- Управление плагинами.
-- В качестве менеджера используется встроенный vim.pack.

-- Автокоманда-хук для отслеживания обновлений плагинов.
-- Должна быть зарегистрирована ДО vim.pack.add. Чтоб сработать не только при
-- обновлении, но и при первой установке плагина.
-- Нужна, например, для того, чтоб обновить парсеры при обновлении nvim-treesitter,
-- а так же установить парсеры на новой машине при первой установке nvim-treesitter.
vim.api.nvim_create_autocmd('PackChanged', {
	desc = 'Отслеживание обновления плагинов',
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		-- nvim-treesitter.
		-- Перекомпилировать парсеры, при обновлении.
		if name == 'nvim-treesitter' and kind == 'update' then
			if not ev.data.active then
				vim.cmd.packadd('nvim-treesitter')
			end
			vim.cmd('TSUpdate')
		end

	end,
})

-- Список плагинов.
vim.pack.add({
	{
		src = 'https://github.com/nvim-treesitter/nvim-treesitter',
		version = 'master'
	},
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/nvim-tree/nvim-tree.lua',
})

-- Подключение конфигураций конкретных плагинов.
require('plugins.treesitter')
require('plugins.fzf')
require('plugins.nvim-tree')
