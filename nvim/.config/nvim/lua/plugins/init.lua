require("lazy").setup({

  -- Snippet engine
  { "L3MON4D3/LuaSnip", lazy = true },

  -- Completion sources
  { "hrsh7th/cmp-nvim-lsp",     lazy = true },
  { "hrsh7th/cmp-buffer",       lazy = true },
  { "hrsh7th/cmp-path",         lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("plugins.completion")
    end,
  },


}, {
  checker = { enabled = false },
  change_detection = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
