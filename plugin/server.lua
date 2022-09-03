vim.cmd "command! ServerRun lua require('server').server()"
vim.cmd "command! ServerToggle lua require('server').server_toggle()"

-- local function map(mode, shortcut, command)
--   vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
-- end
-- map('n', '<leader>t', ':ServerToggle<cr>')
-- map('n', '<leader>g', ':ServerRun<cr>')
