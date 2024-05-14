#ref: https://fishshell.com/docs/3.4/interactive.html#vi-mode-commands
#vim mode
set -g fish_key_bindings fish_vi_key_bindings

bind -M insert \n down-or-search #ctrl+j
bind -M insert \v up-or-search #ctrl+k
bind -M insert \f forward-char #ctrl+l
bind -M insert \b backward-char #ctrl+h
#bind -M insert \cF accept-autosuggestion #ctrl+f
