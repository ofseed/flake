# nvim
set -gx NVIM_HOME "$HOME/neovim"
if not string match -q -- "$NVIM_HOME/bin" $PATH
  set -gx PATH "$NVIM_HOME/bin" $PATH
end
if not string match -q -- "$NVIM_HOME/share" $XDG_DATA_DIRS
  set -gx XDG_DATA_DIRS "$NVIM_HOME/share" $XDG_DATA_DIRS
end
# nvim end

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
