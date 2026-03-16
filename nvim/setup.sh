#!/usr/bin/env bash
# setup.sh — first-time setup helper
# At work: configure your HTTP proxy so git/curl can reach GitHub, then run nvim.
# lazy.nvim will install plugins automatically on first launch.
set -euo pipefail

# ── Proxy configuration ────────────────────────────────────────────────────────
# If you need to set a proxy, uncomment and fill in the line below,
# then re-run this script. It will apply to git globally.
#
# PROXY="http://your-proxy-host:port"
#
# Uncomment to apply:
# git config --global http.proxy  "$PROXY"
# git config --global https.proxy "$PROXY"
#
# To clear proxy settings later:
# git config --global --unset http.proxy
# git config --global --unset https.proxy

echo "==> Current git proxy settings:"
git config --global --get http.proxy  2>/dev/null && echo "  http.proxy:  $(git config --global http.proxy)"  || echo "  http.proxy:  (not set)"
git config --global --get https.proxy 2>/dev/null && echo "  https.proxy: $(git config --global https.proxy)" || echo "  https.proxy: (not set)"
echo ""

echo "==> LSP servers — install manually on each machine:"
echo ""
echo "    Go:        go install golang.org/x/tools/gopls@latest"
echo "    Zig:       zig build -p ~/.local  (from zls source)"
echo "               or download binary: https://github.com/zigtools/zls/releases"
echo "    C/C++:     sudo apt install clangd        # Debian/Ubuntu"
echo "               sudo pacman -S clang           # Arch"
echo "    Python:    pip install pyright"
echo "    YAML:      npm install -g yaml-language-server"
echo "    Terraform: https://releases.hashicorp.com/terraform-ls/"
echo ""
echo "    Verify: which gopls zls clangd pyright yaml-language-server terraform-ls"
echo ""
echo "==> Then just launch nvim — lazy.nvim will install plugins on first run."
