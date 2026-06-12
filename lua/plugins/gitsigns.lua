-- Настройка gitsigns: отображение git-изменений в gutter.

require('gitsigns').setup({
	-- Показывать знаки в неотслеживаемых файлах
	attach_to_untracked = true,
	-- Символы в колонке знаков.
	signs = {
		add          = { text = '┃' },
		change       = { text = '┃' },
		delete       = { text = '▁' },
		topdelete    = { text = '▔' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},

	-- Клавиши навигации и предпросмотра.
	on_attach = function(bufnr)
		local gs = require('gitsigns')

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		-- Навигация по изменениям
		map('n', ']c',
			function()
				if vim.wo.diff then
					vim.cmd.normal({ ']c', bang = true })
				else
					gs.nav_hunk('next')
				end
			end,
			'Следующее git-изменение')

		map('n', '[c',
			function()
				if vim.wo.diff then
					vim.cmd.normal({ '[c', bang = true })
				else
					gs.nav_hunk('prev')
				end
			end,
			'Предыдущее git-изменение')

		-- Предпросмотр изменений под курсором во всплывающем окне.
		map('n', '<leader>gp', gs.preview_hunk, 'Предпросмотр git-изменения')
	end,
})
