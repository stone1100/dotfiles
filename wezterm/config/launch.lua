local options = {
  default_prog = {},
}

-- default use fish shell
options.default_prog =
  { "/opt/homebrew/bin/fish", "-c", "if git rev-parse --is-inside-work-tree >/dev/null 2>&1; onefetch; end; fish" }

return options
