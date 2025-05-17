-- ~/.config/nvim/lua/plugins/completion.lua
return {
  -- LuaSnip + friendly-snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",                                  -- keep up with v2.x releases
    build   = "make install_jsregexp",                 -- optional: faster regex in snippets
    dependencies = { "rafamadriz/friendly-snippets" }, -- collection of community snippets
    config = function()
      local luasnip = require("luasnip")

      -- Basic LuaSnip config
      luasnip.config.set_config {
        history       = true,                           -- keep around last snippet for re-jump
        updateevents  = "TextChanged,TextChangedI",     -- auto-update choices as you type
      }

      -- Load all VSCode-style snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- nvim-cmp: the completion engine
  {
    "hrsh7th/nvim-cmp",
    event        = "InsertEnter",           -- load when you first enter Insert mode
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",               -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",                 -- buffer completions
      "hrsh7th/cmp-path",                   -- filesystem paths
      "hrsh7th/cmp-cmdline",                -- command-line (`:`) completions
      "saadparwaiz1/cmp_luasnip",           -- snippet completions from LuaSnip
      "L3MON4D3/LuaSnip",                   -- ensure LuaSnip is present
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      -- nvim-cmp setup
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-c>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"]  = cmp.mapping.confirm({ select = true }),

          -- Tab to navigate snippets & completion
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })

      -- `/` and `?` in the buffer
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- `:` in command line
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
