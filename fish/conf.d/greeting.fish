function fish_greeting
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1
    onefetch
  else
    fortune | cowsay | lolcat
  end
end
