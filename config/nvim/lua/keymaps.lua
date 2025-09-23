local map = vim.keymap.set

map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file tree" })
vim.cmd("cnoreabbrev wq wqa")
vim.cmd("cnoreabbrev q qa")
