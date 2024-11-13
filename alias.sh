#!/bin/bash

cat <<EOL >> ~/.bashrc
alias ll='ls -lvrt'

alias sshno='ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null"'
alias scpno='scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null"'
alias ssh-copy-idno='ssh-copy-id -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null"'

alias du='du -sh'
alias bcat='batcat'

alias tarnow 'tar -acf '
alias untar 'tar -zxvf '
alias jctl 'journalctl -p 3 -xb'
alias log-find='journalctl -xfeu'
alias port-find='ss -tuln | grep'


#### DOCKER #####
alias d='docker'
alias dps='docker ps'
alias dcon='docker container'
alias dcom='docker compose'
alias dll='docker images'

alias ddel='docker container rm $(docker container ls -aq)'
alias dstop='docker stop $(docker ps -q)'

#belirtilen netwwork ismine bağlı networkleri listeler
alias dn="docker network inspect --format='{{range .Containers}} {{.Name}} {{end}}'"
#belirtilen container'in ip adresini verir
alias dip="docker inspect -f '{{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}'"

#### DOCKER ####

#### K8S ####
alias k='kubectl'
alias kns='kubectl config set-context --current --namespace'


alias ks='kubectl -n kube-system'
alias kcf='kubectl create -f'
alias kaf='kubectl apply -f'
alias kcn='kubectl create namespace'

alias kn='kubectl get nodes'
alias kp='kubectl get pods'
alias kns='kubectl get ns'

alias kpedit='kubectl edit pods'
alias kpdes='kubectl describe pod'
alias kpall='kubectl get pods -A'

alias kexp='kubectl explain'
alias klog='kubectl logs'
alias kall='kubectl get all'


alias krs='kubectl get rs'
alias kpvc='kubectl get pvc'
alias ksvc='kubectl get svc'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'

alias krm='kubectl delete'
alias krmf='kubectl delete -f'
alias kdp='kubectl delete pod'
alias kds='kubectl delete service'
alias kdd='kubectl delete deployment'
alias kdn='kubectl delete namespace'
alias knewtoken='kubeadm token create --print-join-command'
#### K8S ####
EOL

source ~/.bashrc

