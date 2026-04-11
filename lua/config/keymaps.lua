
vim.keymap.set('n', ';', ':', { noremap = true, silent = false })
vim.keymap.set('v', ';', ':', { noremap = true, silent = false })

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Swap line down', silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Swap line up', silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Swap selection down', silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Swap selection up', silent = true })

vim.keymap.set('n', '<C-CR>', 'i<CR><Esc>', { desc = 'Split line at cursor' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc>', function()
  if vim.bo.filetype == 'yazi' then
    return '<Esc>'
  end
  return '<C-\\><C-n>'
end, { expr = true })

vim.keymap.set({ 'n', 'v' }, 'd', '"_d')
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, 'c', '"_c')

vim.keymap.set({ 'n', 'v' }, 'yd', 'd')
vim.keymap.set({ 'n', 'v' }, 'yx', 'd')
vim.keymap.set({ 'n', 'v' }, 'yc', 'd')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

