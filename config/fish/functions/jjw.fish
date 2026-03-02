function jjw
    set name (petname -w 2)
    mkdir -p "../workspaces"
    jj workspace add "../workspaces/$name"
    cd "../workspaces/$name"
    echo $name
end
