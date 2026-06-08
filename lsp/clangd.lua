-- Настройки clangd - LSP-сервера для С.
-- https://clangd.llvm.org/

return {
	cmd = {
		'clangd',
		'--background-index', -- индексировать весь проект в фоне (дает навигацию по всему коду)
		'--clang-tidy',       -- включить дополнительные проверки clang-tidy
	},
	filetypes = { 'c' }, -- только C. Можно доавить 'cpp' для C++
	-- Маркеры корня проекта. По ним clangd определяет границы проекта.
	-- И где искать compile_commands.json / compile_flags.txt.
	root_markers = {
		'compile_commands.json',
		'compile_flags.txt',
		'.clangd',
		'.git',
	},
}
