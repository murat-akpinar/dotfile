#!/bin/bash

cat <<EOL >> ~/.bashrc
alias k='kubectl'
alias kns='kubectl config set-context --current --namespace'


alias ks='kubectl -n kube-system'
alias kcf='kubectl create -f'
alias kaf='kubectl apply -f'

alias kn='kubectl get nodes'
alias kp='kubectl get pods'

alias kpedit='kubectl edit pods'
alias kpdes='kubectl describe pod'
alias kgp='kubectl get pods'
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

EOL
