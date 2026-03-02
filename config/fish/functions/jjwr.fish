function jjwr
    set repo (jj workspace root --name default)

    if test (count $argv) -gt 0
        set name $argv[1]
        if test "$name" = default
            echo "Refusing to remove default workspace"
            return 1
        end
        set workspace "$repo/../workspaces/$name"
    else
        set workspace (jj workspace root)
        set name (basename "$workspace")
        string match -q "*/workspaces/*" "$workspace"; or begin
            echo "Refusing to delete non-workspace: $workspace"
            return 1
        end
    end

    cd $repo
    jj workspace forget $name
    rm -rf $workspace
    echo "Removed $name"
end
