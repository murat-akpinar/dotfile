#!/bin/bash

cat <<EOL >> ~/.bashrc
### SHORTCUTS ###
alias vi='nvim'
alias vim='nvim'
alias whoiss='ps aux | grep pts'
alias secheaders='~/.local/bin/secheaders'

### ALIAS ###

## SSH ##

alias ssh='ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null"'
alias scp='scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null"'

## SSH ##


## FIND ##

alias chng='find . -print0 | xargs -0 stat -c "%Z %z %n" | sort -nr | head -10'
alias lastf="find . -type f -printf '%TY-%Tm-%Td %TH:%TM %p\n' | sort -r | head -n 10"

## FIND ##

## NETWORK ##

alias port-find='sudo ss -tulnp | grep'
alias checkport='sudo ss -tulnp'
alias tr='traceroute'
alias myip='curl ifconfig.me'

## NETWORK ##

## DOCKER ##

alias d='docker'
alias dps='docker ps'
alias dcon='docker container'
alias dcom='docker compose'
alias dls='docker images'
alias drmi='docker rmi'

alias ddel='docker container rm $(docker container ls -aq)'
alias dstop='docker stop $(docker ps -q)'

#belirtilen netwwork ismine bağlı networkleri listeler
alias dn="docker network inspect --format='{{range .Containers}} {{.Name}} {{end}}'"
#belirtilen container'in ip adresini verir
alias dip="docker inspect -f '{{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}'"


## DOCKER ##


## K8S ##

alias k='kubectl'
alias ki='kubectl cluster-info'

function kset() {
    local ns="$1"
    kubectl config set-context --current --namespace="$ns"
}

alias ks='kubectl -n kube-system'
alias kcf='kubectl create -f'
alias kcn='kubectl create namespace'
alias kdn='kubectl delete namespace'

alias knls='kubectl get nodes'
alias kp='kubectl get pods'
alias kns='kubectl get ns'
alias kls='kubectl get pods -A'
alias kll='kubectl get all'

alias kapp='kubectl apply -f'

alias kedit='kubectl edit pods'
alias kdes='kubectl describe pod'

alias kexp='kubectl explain'
alias klog='kubectl logs'

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
alias knewtoken='kubeadm token create --print-join-command'

## K8S ##

## GLOBAL ENV ##
export EDITOR=nvim
export VISUAL=nvim
## GLOBAL ENV ##

EOL

source ~/.bashrc

