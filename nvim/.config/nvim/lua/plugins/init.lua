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

  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>",       desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>",   desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",     desc = "Buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",    desc = "Recent files" },
      { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
      { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>fc", "<cmd>FzfLua lsp_incoming_calls<cr>",   desc = "Incoming calls" },
      { "gr",         "<cmd>FzfLua lsp_references<cr>",       desc = "LSP references" },
    },
    config = function()
      require("fzf-lua").setup({ "default" })
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
