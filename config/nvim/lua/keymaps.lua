-- Open lir in current file’s directory with <leader>e
vim.keymap.set("n", "<leader>e", function()
  require("lir.float").toggle()
end, { noremap = true, silent = true })


