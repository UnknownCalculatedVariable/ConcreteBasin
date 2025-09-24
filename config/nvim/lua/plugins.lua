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
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'elkowar/yuck.vim'
  Plug 'nvim-mini/mini.nvim'
  Plug 'MeanderingProgrammer/render-markdown.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'tamago324/lir.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'numToStr/FTerm.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'romgrk/barbar.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'          " completion engine
  Plug 'hrsh7th/cmp-buffer'        " buffer completions
  Plug 'hrsh7th/cmp-path'          " path completions
  Plug 'hrsh7th/cmp-nvim-lsp'      " LSP completions
  Plug 'hrsh7th/cmp-nvim-lua'      " neovim lua API completions
  Plug 'L3MON4D3/LuaSnip'          " snippet engine
  Plug 'saadparwaiz1/cmp_luasnip'  " snippet completions
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

  call plug#end()
]]

require("config.lir")
require("config.autopairs")
require("config.fterm")
require("config.telescope")
require("config.lualine")
require("config.barbar")
require("config.cmp")
