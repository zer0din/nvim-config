# nvim-config

Персональная конфигурация NeoVim для использования в качестве IDE.
Целевая система - Fedora Linux.

## Требования

NeoVim ≥ 0.12. 
Конфиг использует встроенный менеджер плагинов `vim.pack`, встроенный LSP API (`vim.lsp.config` / `vim.lsp.enable`) и встроенное автодополнение (`vim.lsp.completion`), появившиеся в 0.11–0.12. На более старых версиях работать не будет.

## Установка

### 1. Установка

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

### 3. Системные пакеты

```bash
sudo dnf install lua-language-server clang-tools-extra fzf ripgrep fd-find
```

- `lua-language-server` - LSP-сервер для Lua
- `clang-tools-extra` - LSP-сервер для C (использует compile_flags.txt для многофайловых проектов)
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
DCD (автодополнение), dfmt (форматирование) и dscanner (линтинг)
вкомпилированы в serve-d - отдельно ставить не нужно.

