-- Настройки LSP инфраструктуры.

-- Внешний вид диагностики.
vim.diagnostic.config({
	-- Виртуальные текст справа от строки с ошибкой.
	virtual_text = {
		-- Отступ от текста, до кода сообщения.
		spacing = 4,
		-- Префикс перед сообщением.
		prefix = '●',
	},
	-- Подчеркивание проблемного участка.
	underline = true,
	-- Знаки в signcolumn (E, W, H, I).
	signs = true,
	-- Сортировать диагностики по серьезности.
	severity_sort = true,
	-- Всплывающее окно
	float = {
		border = 'rounded',
		source = true,
	},
})

-- Назначения клавиш. Действую при подключении сервера к буферу.
-- LspAttach срабатывает каждый раз, когда сервер подключается к буферу.
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP-маппинги для подключенного буфера',
	callback = function(ev)
		local opts = { buffer = ev.buf }

		-- Стандартные назначения:
		-- 'K' - отображает документацию под курсором.
		-- grn - rename
		-- gra - code action
		-- grr - все ссылки на символ
		-- gri - переходы к реализациям

		-- Перейти к определению.
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
			vim.tbl_extend('force', opts, { desc = 'LSP: к определению' }))
		-- Перейти к декларации. Для Lua совпадает с определением. Для некоторых
		-- языков это разные вещи.
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
			vim.tbl_extend('force', opts, { desc = 'LSP: к декларации' }))

		-- Показать диагностику текущей строки во всплывающем окне.
		vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float,
			vim.tbl_extend('force', opts, { desc = 'Показать диагностику строки' }))

		-- Включить автодоплнение по триггерным символам сервера.
		if ev.data and ev.data.client_id then
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client and client:supports_method('textDocument/completion') then
				vim.lsp.completion.enable(true, client.id, ev.buf, {
					autotrigger = true,
				})
			end
		end
	end,
})

-- Активация LSP.
-- Имена соответствуют файлам в ~/.config/nvin/lua/lsp/.
vim.lsp.enable({
	'lua_ls',  -- Lua
	'clangd',  -- C
	'serve_d', -- D
})
