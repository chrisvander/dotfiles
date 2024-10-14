if not status is-interactive && test "$CI" != true
  exit
end

zoxide init fish | source
