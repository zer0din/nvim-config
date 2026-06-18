# nvim-config

Персональная конфигурация NeoVim для использования в качестве IDE.
Целевая система - Fedora Linux.

## Требования

NeoVim ≥ 0.12. 
Конфиг использует встроенный менеджер плагинов `vim.pack`, встроенный LSP API (`vim.lsp.config` / `vim.lsp.enable`) и встроенное автодополнение (`vim.lsp.completion`), появившиеся в 0.11–0.12. На более старых версиях работать не будет.

## Установка

### 1. Конфиг

```bash
git clone https://github.com/zer0din/nvim-config.git ~/.config/nvim
```

### 2. Плагины

Ставятся автоматически при первом запуске `nvim` через `vim.pack`.
При первом старте появится запрос на установку - подтвердить.
Версии зафиксированы в `nvim-pack-lock.json`, на новой машине поставятся те же.

- `fzf-lua` - нечёткий поиск (файлы, текст, буферы)
- `nvim-tree.lua` - дерево файлов
- `nvim-web-devicons` - иконки
- `gitsigns.nvim` - индикаторы git-изменений в gutter
- `nvim-dap`, `nvim-dap-ui`, `nvim-nio` - отладка (DAP)

### 3. Системные пакеты

```bash
sudo dnf install lua-language-server clang-tools-extra ShellCheck gdb fzf ripgrep fd-find
```

- `lua-language-server` - LSP-сервер для Lua
- `clang-tools-extra` - LSP-сервер для C (использует compile_flags.txt для многофайловых проектов)
- `ShellCheck` - диагностика shell-скриптов (подключается напрямую, без LSP)
- `gdb` - отладчик (используется как DAP-сервер в режиме `gdb -i dap`, для C и D)
- `fzf`, `ripgrep`, `fd-find` - внешние утилиты для `fzf-lua`

Для иконок в дереве файлов нужен установленный в системе шрифт Nerd Font,
выбранный шрифтом терминала.

### 4. serve-d - LSP-сервер для D (сборка из исходников)

В репозиториях Fedora пакета нет. Зависимости для сборки:

```bash
sudo dnf install ldc dub libcurl-devel
```

Сборка и установка:

```bash
git clone --recursive https://github.com/Pure-D/serve-d.git ~/src/serve-d
cd ~/src/serve-d
git checkout v0.8.0-beta.18
git submodule update --init --recursive
dub build --build=release --compiler=ldc2
cp ~/src/serve-d/serve-d ~/.local/bin/
```

serve-d должен оказаться в `PATH`. Проверка: `serve-d --version`.
DCD (автодополнение), dfmt (форматирование) и dscanner (линтинг) вкомпилированы в serve-d - отдельно ставить не нужно.

## Поддержка PlayDate

Требуется установленный Playdate SDK с заданной переменной окружения `PLAYDATE_SDK_PATH`.

### Аннотации API для автодополнения

Работу с API PlayDate в lua_ls обеспечивают аннотации сообщества (LuaCATS):

```bash
git clone https://github.com/notpeter/playdate-luacats ~/<директория_для_LuaCATS>
```

### Настройка проекта

Каждый PlayDate-проект описывает своё окружение сам через `.luarc.json` в каталоге исходников (рядом с `main.lua` и `pdxinfo`). Пример:

```json
{
	"runtime.version": "Lua 5.4",
	"runtime.nonstandardSymbol": ["+=", "-=", "*=", "/=", "//=", "%=", "<<=", ">>=", "&=", "|=", "^="],
	"diagnostics.globals": ["import"],
	"workspace.library": ["<директория_для_LuaCATS>"],
	"runtime.builtin": {
		"io": "disable",
		"os": "disable",
		"package": "disable"
	}
}
```

## Окружения Lua

Конфиг lua_ls (`lsp/lua_ls.lua`) нейтральный, без привязки к окружению. Специфику каждый проект задаёт через свой `.luarc.json`:
- Конфиг nvim - `.luarc.json` в корне (LuaJIT, `vim`, runtime nvim и плагины)
- PlayDate-проекты - `.luarc.json` в каталоге исходников
- Прочие Lua-проекты - нейтральные настройки или собственный `.luarc.json`
