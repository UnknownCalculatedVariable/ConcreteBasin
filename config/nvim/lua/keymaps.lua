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

