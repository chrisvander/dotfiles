set FILE "$HOME/.local/state/font-awesome/faapitoken"
if [ -f $FILE ]
  export FA_API_TOKEN=$(cat $FILE)
end
