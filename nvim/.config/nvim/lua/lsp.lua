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

    local function o(desc) return vim.tbl_extend("force", opts, { desc = desc }) end
    local fzf = require("fzf-lua")

    -- Doom's evil lookup keys
    map("n", "gd", vim.lsp.buf.definition, o("Jump to definition"))
    map("n", "gD", fzf.lsp_references,     o("Find references"))
    map("n", "K",  vim.lsp.buf.hover,      o("Documentation"))
    map("i", "<C-k>", vim.lsp.buf.signature_help, o("Signature help"))

    -- SPC c: code
    map("n", "<leader>ca", vim.lsp.buf.code_action,  o("Code action"))
    map("n", "<leader>cr", vim.lsp.buf.rename,       o("Rename"))
    map({ "n", "v" }, "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, o("Format buffer/region"))
    map("n", "<leader>cd", vim.lsp.buf.definition,   o("Jump to definition"))
    map("n", "<leader>cD", fzf.lsp_references,       o("Jump to references"))
    map("n", "<leader>ci", fzf.lsp_implementations,  o("Find implementations"))
    map("n", "<leader>ct", fzf.lsp_typedefs,         o("Find type definition"))
    map("n", "<leader>ck", vim.lsp.buf.hover,        o("Jump to documentation"))
    map("n", "<leader>cj", fzf.lsp_live_workspace_symbols, o("Jump to symbol in workspace"))
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

-- ── Nix ───────────────────────────────────────────────────────────────────────
-- Completes NixOS options from the flake in ~/nixos
local nixos_flake = 'builtins.getFlake "' .. vim.fn.expand("~/nixos") .. '"'
vim.lsp.config("nixd", {
  cmd          = { "nixd" },
  filetypes    = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    nixd = {
      nixpkgs    = { expr = "import (" .. nixos_flake .. ").inputs.nixpkgs {}" },
      formatting = { command = { "nixfmt" } },
      options    = {
        nixos = { expr = "(" .. nixos_flake .. ").nixosConfigurations.nuccu.options" },
      },
    },
  },
})

-- Enable each server only if its program is installed on this machine,
-- so the same config works at home and at work.
local servers = {
  gopls       = "gopls",
  zls         = "zls",
  clangd      = "clangd",
  pyright     = "pyright-langserver",
  yamlls      = "yaml-language-server",
  terraformls = "terraform-ls",
  nixd        = "nixd",
}
for name, bin in pairs(servers) do
  if vim.fn.executable(bin) == 1 then
    vim.lsp.enable(name)
  end
end
