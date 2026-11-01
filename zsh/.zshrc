# grml's zsh config is the base on every machine.
# NixOS loads it system-wide (modules/shell.nix) before this file runs.
# Elsewhere (e.g. work), load the copy kept here: .zshrc.grml (grml 0.20.1).
if [[ -z $GRML_OSTYPE && -r ~/.zshrc.grml ]]; then
  source ~/.zshrc.grml
fi

# Personal settings below. They run after grml, so they override it.
