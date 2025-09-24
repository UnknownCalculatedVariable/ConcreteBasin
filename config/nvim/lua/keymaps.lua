-- Open lir in current file’s directory with <leader>e
vim.keymap.set("n", "<leader>e", function()
  require("lir.float").toggle()
end, { noremap = true, silent = true })

-- FTerm

-- Load FTerm
require("FTerm").setup({})

-- Keymaps
vim.keymap.set('n', '<leader>i', function() require("FTerm").toggle() end, { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', function() require("FTerm").toggle() end, { noremap = true, silent = true })

-- /FTerm

-- Barbar

-- Move between buffers
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })

-- Re-order buffers
vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { noremap = true, silent = true })

-- Close buffer
vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", { noremap = true, silent = true })

-- /Barbar

-- Telescope

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- /Telescope
