vim.pack.add({
  -- Snippet engine
  "https://github.com/L3MON4D3/LuaSnip",

  -- Completion sources
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/saadparwaiz1/cmp_luasnip",

  -- Completion engine
  "https://github.com/hrsh7th/nvim-cmp",

  -- Fuzzy finder
  "https://github.com/ibhagwan/fzf-lua",
})

require("plugins.completion")
require("fzf-lua").setup({ "default" })
