-- Leader клавиши. Нужно задать до всеx последующих привязок
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

-- Полключение модулей с настройками
require('core.options')  -- Базовые опции
require('core.keymaps')  -- Привязки клавиш
require('core.autocmds') -- Автокоманды
require('plugins')       -- Плагины (lua/plugins/init.lua).
