function jjws
    set ws (jj workspace list \
        | awk -F: '{print $1}' \
        | fzf)

    test -n "$ws"; and cd (jj workspace root --name "$ws")
end
