if status is-interactive
    # Commands to run in interactive sessions can go here
end

function starship_transient_prompt_func
  starship module character
end

function starship_transient_rprompt_func
  starship module time
end

starship init fish | source
enable_transience

# fix gpg fail
set -gx GPG_TTY (tty)

# git editor
set -gx GIT_EDITOR nvim
