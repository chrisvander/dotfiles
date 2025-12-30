# pnpm
set -gx PNPM_HOME "/Users/chrisvanderloo/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# uv
fish_add_path "/Users/chrisvanderloo/.local/share/../bin"
