return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")

      lsp.pyright.setup({})
      lsp.gopls.setup({})
      lsp.yamlls.setup({})
      lsp.terraformls.setup({})
      lsp.bashls.setup({})
    end,
  },
}
