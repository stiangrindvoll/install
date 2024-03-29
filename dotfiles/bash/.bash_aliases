alias ahp='awsudo -u haven_prod'
alias ahd='awsudo -u haven_dev'
alias ahpi='awsudo -u haven_prod python /home/stian/.local/bin/aws-instances.py'
alias ahdi='awsudo -u haven_dev python /home/stian/.local/bin/aws-instances.py'
alias stow='stow -t $HOME'
alias ff='fzf'
alias ipfs-start='systemctl --user enable --now ipfs'
alias k8='kubectl'
alias kc='kubectl'
alias gps='gp show'
alias scp='rsync --archive --xattrs --acls --progress --rsh="ssh"'
alias bat='bat -p --theme=TwoDark'
alias random='od  -vN 32 -An -tx1 /dev/urandom | tr -d " \n" | base64 -w 0 -'
