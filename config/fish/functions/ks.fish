function ks --wraps='kubectl config use-context' --description 'alias ks kubectl config use-context'
  kubectl config use-context $argv
        
end
