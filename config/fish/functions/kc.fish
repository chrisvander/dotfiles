function kc --wraps='kubectl config get-contexts' --description 'alias kc kubectl config get-contexts'
  kubectl config get-contexts $argv
        
end
