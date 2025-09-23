-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugin list
require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-lua/plenary.nvim" },
  	{
  	"folke/which-key.nvim",
  	event = "VeryLazy",
  	opts = {
    	-- your configuration comes here
    	-- or leave it empty to use the default settings
    	-- refer to the configuration section below
  	},
  	keys = {
   	 {
      	"<leader>?",
      	function()
       	 require("which-key").show({ global = false })
      	end,
	      desc = "Buffer Local Keymaps (which-key)",
	    },
	    },
	},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  },
  { "elkowar/yuck.vim" },
  { "s1n7ax/nvim-terminal"},
})

