-- ~/.config/nvim/lua/plugins/lsp.lua
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Mason: install & manage LSP servers
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls" },
				automatic_enable = {
					exclude = { "ts_ls", "tailwindcss" },       -- ← Mason will NOT auto-enable ts_ls
				},
			})

			-- Common on_attach for all LSP clients
			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }

				-- LSP navigation
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration,    opts)
				vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition,     opts)
				vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<leader>R", vim.lsp.buf.references,     opts)

				-- Refactor & code actions
				vim.keymap.set("n", "<leader>r",  vim.lsp.buf.rename,      opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

				-- Documentation & diagnostics
				vim.keymap.set("n", "K",      vim.lsp.buf.hover,          opts)
				vim.keymap.set("n", "<C-k>",  vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>e", vim.diagnostic.goto_next,  opts)
				vim.keymap.set("n", "<leader>E", vim.diagnostic.goto_prev,  opts)

				-- Remove unused imports only
				vim.keymap.set("n", "<leader>di", function()
					vim.lsp.buf.code_action({
						context = { only = { "source.removeUnusedImports.ts" } },
						apply   = true,
					})
				end, { buffer = bufnr, desc = "LSP: Remove Unused Imports" })

			end

			-- LSP capabilities from nvim-cmp
			local capabilities =
			require("cmp_nvim_lsp").default_capabilities()

			-- TypeScript / JavaScript LSP
			local lspconfig = require("lspconfig")
			local util      = require("lspconfig.util")

			lspconfig.tailwindcss.setup({
				capabilities = capabilities,       -- from cmp_nvim_lsp
				on_attach    = on_attach,          -- your existing on_attach handler
				filetypes    = {
					"html", "css", "scss",
					"javascript", "javascriptreact",
					"typescript", "typescriptreact",
					"vue", "svelte",
				},
				root_dir     = util.root_pattern(
					"tailwind.config.js", "postcss.config.js", "package.json", ".git"
				),
				init_options = {
					userLanguages = {
						-- map filetypes to languages if needed, e.g. heex → html
						heex = "html"
					}
				},
			})

			lspconfig.ts_ls.setup({
				capabilities        = capabilities,
				on_attach          = on_attach,
				root_dir           = util.root_pattern("package.json", "tsconfig.json", ".git"),
				single_file_support = false,
				init_options       = {
					preferences = {
						importModuleSpecifierPreference   = "non-relative",
						includeCompletionsForModuleExports = true,
						includeCompletionsWithInsertText   = true,
					},
				},
			})
		end,
	}
}
