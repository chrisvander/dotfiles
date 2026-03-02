complete -c jjwr -f -a "(jj workspace list | awk -F: '{print \$1}' | grep -v '^default\$')" -d "jj workspace"
