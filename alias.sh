#!/bin/bash

cat <<EOL >> ~/.bashrc
alias ll='ls -lvrt'

alias sshno='ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null"'
alias scpno='scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null"'
alias ssh-copy-idno='ssh-copy-id -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null"'

alias cdd='cd ..'
alias cddd='cd ../..'

alias du='du -sh *'
alias bcat='batcat'
alias chng='find . -print0 | xargs -0 stat -c "%Z %z %n" | sort -nr | head -10'

alias outtar='tar -xzvf'
alias inntar='tar -cvf' 

alias scpfile='function _scpcp() {
    scp "$1" "$2";
    dosya=$(basename "$1");
    hedef=$(echo "$2" | sed "s/:.*//"); # Hedef adresi ayıklar
    hash_kaynak=$(sha256sum "$1" | awk "{ print \$1 }");
    hash_hedef=$(ssh "$hedef" "sha256sum /root/$dosya" | awk "{ print \$1 }");
    if [ "$hash_kaynak" == "$hash_hedef" ]; then
        echo "Başarılı: Dosya bütünlüğü doğrulandı.";
    else
        echo "Başarısız: Dosya bütünlüğü doğrulanamadı!";
    fi;
    unset -f _scpcp;
}; _scpcp'

alias rcpfile='function _cpcp() {
    rsync -ah --progress "$1" "$2";
    dosya=$(basename "$1");
    if [ -d "$2" ]; then
        hedef_dizin="$2";
        tam_hedef="$hedef_dizin/$dosya";
    else
        tam_hedef="$2";
    fi
    hash_kaynak=$(sha256sum "$1" | awk "{ print \$1 }");
    hash_hedef=$(sha256sum "$tam_hedef" | awk "{ print \$1 }");
    if [ "$hash_kaynak" == "$hash_hedef" ]; then
        echo "Başarılı: Dosya bütünlüğü doğrulandı.";
    else
        echo "Başarısız: Dosya bütünlüğü doğrulanamadı!";
    fi;
    unset -f _cpcp;
}; _cpcp'


#### DOCKER #####
alias d='docker'
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

