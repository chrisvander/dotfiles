function tree --wraps='eza -ah --icons=always --tree --level=3 --git-ignore --ignore-glob=".git|node_modules|.DS_Store"' --description 'alias tree eza -ah --icons=always --tree --level=3 --git-ignore --ignore-glob=".git|node_modules|.DS_Store"'
  eza -ah --icons=always --tree --level=3 --git-ignore --ignore-glob=".git|node_modules|.DS_Store" $argv
        
end
