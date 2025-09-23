-- Bootstrap vim-plug if it's not installed
local plug_path = vim.fn.stdpath("data") .. "/site/autoload/plug.vim"
if vim.fn.empty(vim.fn.glob(plug_path)) > 0 then
  vim.fn.system({
    "curl", "-fLo", plug_path, "--create-dirs",
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  })
end

-- Start vim-plug plugin section
vim.cmd [[
  call plug#begin(stdpath('data') . '/plugged')

  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'elkowar/yuck.vim'
  Plug 'nvim-mini/mini.nvim'
  Plug 'MeanderingProgrammer/render-markdown.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'tamago324/lir.nvim'
  Plug 'windwp/nvim-autopairs'

  call plug#end()
]]

require("config.lir")
require("config.autopairs")
