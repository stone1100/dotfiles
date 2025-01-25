# If you come from bash you might have to change your $PATH.
fish_add_path /opt/homebrew/bin
fish_add_path ~/go/bin
fish_add_path /usr/local/go/bin
fish_add_path /usr/local/bin
fish_add_path /usr/local/apache-maven-3.8.6/bin

set -gx PNPM_PATH "$HOME/Library/pnpm/"

fish_add_path $PNPM_PATH

fish_add_path ~/Library/Python/3.9/bin
