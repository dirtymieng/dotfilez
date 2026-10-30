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

  -- Fuzzy finder (needs fzf, ripgrep, fd)
  "https://github.com/ibhagwan/fzf-lua",

  -- Doom-style leader menu popup
  "https://github.com/folke/which-key.nvim",

  -- Git: magit-like status (Neogit) and gutter signs/hunks (gitsigns)
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/lewis6991/gitsigns.nvim",

  -- Directory editing like dired
  "https://github.com/stevearc/oil.nvim",
})

require("plugins.completion")
require("fzf-lua").setup({ "default" })

require("oil").setup()
require("neogit").setup({})

require("gitsigns").setup({
  on_attach = function(buf)
    local gs = require("gitsigns")
    local opts = { buffer = buf }
    -- Hunks: ]d / [d like Doom's vc-gutter
    vim.keymap.set("n", "]d", function() gs.nav_hunk("next") end,
      vim.tbl_extend("force", opts, { desc = "Next hunk" }))
    vim.keymap.set("n", "[d", function() gs.nav_hunk("prev") end,
      vim.tbl_extend("force", opts, { desc = "Previous hunk" }))
  end,
})

local wk = require("which-key")
wk.setup({ preset = "helix", delay = 300 })
wk.add({
  { "<leader>b", group = "buffer" },
  { "<leader>c", group = "code" },
  { "<leader>f", group = "file" },
  { "<leader>g", group = "git" },
  { "<leader>h", group = "help" },
  { "<leader>o", group = "open" },
  { "<leader>p", group = "project" },
  { "<leader>q", group = "quit" },
  { "<leader>s", group = "search" },
  { "<leader>t", group = "toggle" },
  { "<leader>w", group = "window" },
  { "<leader><tab>", group = "workspace" },
})
