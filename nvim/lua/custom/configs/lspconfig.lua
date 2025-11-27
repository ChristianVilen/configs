local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {"ts_ls", "tailwindcss", "eslint"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local function find_tsconfig_dir()
    return lspconfig.util.root_pattern("tsconfig.json")(vim.fn.expand("%:p:h"))
end

lspconfig.eslint.setup {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  capabilities = capabilities,
  root_dir = find_tsconfig_dir,
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}

lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = false,
  root_dir = find_tsconfig_dir,
})

lspconfig.gopls.setup {
  cmd = { "gopls" },
  filetypes = { "go", "gomod" },
  capabilities = capabilities,
  root_dir = require('lspconfig.util').root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
        unreachable = true,
      },
      staticcheck = true,
    },
  },
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}

lspconfig.svelte.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Show diagnostics in float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set diagnostics to loclist" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Jump to declaration", unpack(opts) })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Jump to definition", unpack(opts) })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover", unpack(opts) })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Jump to implementation", unpack(opts) })
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Show signature help", unpack(opts) })
		vim.keymap.set(
			"n",
			"<space>wa",
			vim.lsp.buf.add_workspace_folder,
			{ desc = "Add workspace folder", unpack(opts) }
		)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { desc = "Jump to type definition", unpack(opts) })
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol", unpack(opts) })
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { desc = "Code action", unpack(opts) })
		vim.keymap.set("n", "<space>cff", vim.lsp.buf.format, { desc = "Quick format", unpack(opts) })
		vim.keymap.set(
			"n",
			"gr",
			":Telescope lsp_references<CR>",
			{ buffer = bufnr, desc = "Find references", unpack(opts) }
		)
		vim.keymap.set("n", "<space>b", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format buffer", unpack(opts) })
		vim.keymap.set(
			"n",
			"<space>wr",
			vim.lsp.buf.remove_workspace_folder,
			{ desc = "Remove workspace folder", unpack(opts) }
		)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { desc = "List workspace folders", unpack(opts) })
	end,
})
