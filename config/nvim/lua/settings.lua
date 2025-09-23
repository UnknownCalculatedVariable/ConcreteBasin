vim.g.mapleader = " " -- space as leader
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = false



-- auto-quit if Neo-tree is the last window
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "neo-tree://*",
  callback = function()
    if #vim.api.nvim_list_wins() == 1 then
      vim.cmd("quit")
    end
  end,
})

