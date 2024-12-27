mkdir -p $HOME/.local/state/font-awesome
set FILE "$HOME/.local/state/font-awesome/faapitoken"
if [ -f $FILE ]
    export FA_API_TOKEN=$(cat $FILE)
else
    mise x 1password-cli@latest -- op read "op://ci/Font Awesome API Token/password" >$FILE
    export FA_API_TOKEN=$(cat $FILE)
end
