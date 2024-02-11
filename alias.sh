cat <<EOL >> ~/.bashrc

alias ll='ls -lvrt'

alias cdd='cd ..'
alias cddd='cd ../..'

alias du='du -sh *'
alias bcat='batcat'
alias chng='find . -print0 | xargs -0 stat -c "%Z %z %n" | sort -nr | head -10'

#### DOCKER #####

alias dc='docker compose'
alias di='docker images'
alias dcdel='docker container rm $(docker container ls -aq)'

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

alias kn='kubectl get nodes'
alias kp='kubectl get pods'

alias kpedit='kubectl edit pods'
alias kpdes='kubectl describe pod'
alias kgp=' '
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
EOL

source ~/.bashrc

