set -g fish_greeting

if status is-interactive
    starship init fish | source
end

neofetch



# List Directory
alias ls="lsd"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'

####

alias ll='ls -lvrt'

alias cdd='cd ..'
alias cddd='cd ../..'

alias du='du -sh *'
alias bcat='batcat'
alias chng='find . -print0 | xargs -0 stat -c "%Z %z %n" | sort -nr | head -10'

alias outtar='tar -xzvf'
alias inntar='tar -cvf' 

###


###

#### DOCKER #####
alias d='docker'
alias dcon='docker container'
alias dcom='docker compose'
alias dll='docker images'

alias ddel='docker container rm '
alias dstop='docker stop '

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


alias skube-login-ubuntu='docker run --name skube-builder --rm -it  skube/skube-builder:0.62-u /bin/bash'
alias skube-login-oracle='docker run --name skube-builder --rm -it  skube/skube-builder:0.70-ol-mehkks /bin/bash'

