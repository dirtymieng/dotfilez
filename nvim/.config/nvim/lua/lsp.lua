-- Native LSP configuration for Neovim 0.11+
-- No nvim-lspconfig required. Uses vim.lsp.config / vim.lsp.enable.

-- Advertise nvim-cmp completion capabilities to all servers
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Keymaps and settings applied whenever any LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = vim.keymap.set
    local opts = { buffer = args.buf, silent = true }

    map("n", "gd",         vim.lsp.buf.definition,     vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    map("n", "gD",         vim.lsp.buf.declaration,    vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    map("n", "gi",         vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    map("n", "gr",         vim.lsp.buf.references,     vim.tbl_extend("force", opts, { desc = "References" }))
    map("n", "K",          vim.lsp.buf.hover,          vim.tbl_extend("force", opts, { desc = "Hover docs" }))
    map("n", "<C-k>",      vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
    map("n", "<leader>rn", vim.lsp.buf.rename,         vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    map("n", "<leader>ca", vim.lsp.buf.code_action,    vim.tbl_extend("force", opts, { desc = "Code action" }))
    map("n", "<leader>f",  function()
      vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
  end,
})

-- Diagnostic display
vim.diagnostic.config({
  virtual_text    = { spacing = 4, prefix = "●" },
  signs           = true,
  underline       = true,
  update_in_insert = false,
  severity_sort   = true,
})

-- ── Go ────────────────────────────────────────────────────────────────────────
vim.lsp.config("gopls", {
  cmd          = { "gopls" },
  filetypes    = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      analyses        = { unusedparams = true, shadow = true },
      staticcheck     = true,
      gofumpt         = true,
      usePlaceholders = true,
    },
  },
})

-- ── Zig ───────────────────────────────────────────────────────────────────────
vim.lsp.config("zls", {
  cmd          = { "zls" },
  filetypes    = { "zig", "zir" },
  root_markers = { "build.zig", "build.zig.zon", ".git" },
})

-- ── C / C++ ───────────────────────────────────────────────────────────────────
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=never",
  },
  filetypes    = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = { "compile_commands.json", "CMakeLists.txt", ".git" },
})

-- ── Python ────────────────────────────────────────────────────────────────────
vim.lsp.config("pyright", {
  cmd          = { "pyright-langserver", "--stdio" },
  filetypes    = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode      = "basic",
        autoImportCompletions = true,
      },
    },
  },
})

-- ── YAML ──────────────────────────────────────────────────────────────────────
vim.lsp.config("yamlls", {
  cmd          = { "yaml-language-server", "--stdio" },
  filetypes    = { "yaml", "yaml.docker-compose" },
  root_markers = { ".git" },
  settings = {
    yaml = {
      validate   = true,
      hover      = true,
      completion = true,
      schemaStore = { enable = false, url = "" },
    },
  },
})

-- ── Terraform ─────────────────────────────────────────────────────────────────
vim.lsp.config("terraformls", {
  cmd          = { "terraform-ls", "serve" },
  filetypes    = { "terraform", "terraform-vars", "hcl" },
  root_markers = { ".terraform", ".git" },
})

-- Enable all configured servers (only activates if the binary is on PATH)
vim.lsp.enable({ "gopls", "zls", "clangd", "pyright", "yamlls", "terraformls" })
