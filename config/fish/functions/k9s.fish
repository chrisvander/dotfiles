function k9s --description 'alias k9s k9s && echo "hi"'
    if ! aws sts get-caller-identity &>/dev/null
        aws sso login
    end
    command k9s $argv
end
