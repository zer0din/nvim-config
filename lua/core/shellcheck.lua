-- Диагностика shell-скриптов через внешний shellcheck.
-- Не использует LSP: shellcheck запускается напрямую, результат кладётся
-- в собственный namespace vim.diagnostic. NeoVim рисует его так же, как
-- диагностику от LSP-серверов.

-- Свой namespace - чтобы диагностики не смешивались с чужими
-- и их можно было обновлять/очищать независимо.
local ns = vim.api.nvim_create_namespace('shellcheck')

-- Соответствие уровней shellcheck уровням vim.diagnostic.
local severity_map = {
	error   = vim.diagnostic.severity.ERROR,
	warning = vim.diagnostic.severity.WARN,
	info    = vim.diagnostic.severity.INFO,
	style   = vim.diagnostic.severity.HINT,
}

-- Запуск проверки для конкретного буфера.
local function run(buf)
	-- Имя файла буфера. Если буфер не сохранён на диск - пропускаем
	-- (shellcheck работает с файлом).
	local file = vim.api.nvim_buf_get_name(buf)
	if file == '' then
		return
	end

	-- Асинхронный запуск. Не подвешивает редактор.
	vim.system(
		{ 'shellcheck', '--format=json', file },
		{ text = true },
		function(result)
			-- Колбэк выполняется в "быстром контексте", где нельзя
			-- трогать буферы напрямую - откладываем через vim.schedule.
			vim.schedule(function()
				-- Буфер мог быть закрыт, пока shellcheck работал.
				if not vim.api.nvim_buf_is_valid(buf) then
					return
				end

				-- shellcheck возвращает ненулевой код, если нашёл проблемы -
				-- это нормально, ошибкой запуска не считаем. Разбираем stdout.
				local ok, parsed = pcall(vim.json.decode, result.stdout)
				if not ok or type(parsed) ~= 'table' then
					-- Не разобрался (пустой вывод/мусор) - чистим диагностику.
					vim.diagnostic.set(ns, buf, {})
					return
				end

				local diagnostics = {}
				for _, item in ipairs(parsed) do
					table.insert(diagnostics, {
						-- shellcheck нумерует с 1, vim.diagnostic - с 0.
						lnum     = item.line - 1,
						end_lnum = item.endLine - 1,
						col      = item.column - 1,
						end_col  = item.endColumn - 1,
						severity = severity_map[item.level] or vim.diagnostic.severity.WARN,
						message  = item.message,
						-- Код вида SC2086 - в источник, отображается рядом.
						source   = 'shellcheck',
						code     = 'SC' .. item.code,
					})
				end

				vim.diagnostic.set(ns, buf, diagnostics)
			end)
		end
	)
end

-- Запуск при открытии и сохранении shell-скриптов.
local group = vim.api.nvim_create_augroup('Shellcheck', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
	group = group,
	pattern = { '*.sh', '*.bash' },
	desc = 'Проверка shell-скриптов через shellcheck',
	callback = function(ev)
		run(ev.buf)
	end,
})
