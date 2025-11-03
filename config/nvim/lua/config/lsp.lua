-- Get server definition from lspconfig
local configs = require("lspconfig.configs")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config["qmlls"] = {
  default_config = {
    cmd = { "qmlls" },
    filetypes = { "qml" },
    root_dir = vim.fs.dirname(vim.fs.find({ "CMakeLists.txt", "qmlproject", ".git" }, { upward = true })[1]),
    single_file_support = true,
    capabilities = capabilities,
  },
}

-- Start/attach LSP
vim.lsp.start({ name = "qmlls" })

