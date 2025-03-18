local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local opts = {
  sources = {
    null_ls.builtins.formatting.prettierd.with({
      condition = function(utils)
        -- Ensure that Prettier runs if either package.json or .prettierrc exists
        return utils.root_has_file("package.json") or utils.root_has_file(".prettierrc")
      end,
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ 
        group = augroup, 
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    else
      print("LSP does not support formatting")
    end
  end,
  autostart = true,
}

return opts
