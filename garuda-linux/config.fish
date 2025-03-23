## Set values
# Hide welcome message & ensure we are reporting fish as shell
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -xU MANROFFOPT "-c"
set -x SHELL /usr/bin/fish

## Export variable need for qt-theme
if type "qtile" >> /dev/null 2>&1
   set -x QT_QPA_PLATFORMTHEME "qt5ct"
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Starship prompt
if status --is-interactive
   source ("/usr/bin/starship" init fish --print-full-init | psub)
end


## Advanced command-not-found hook
#source /usr/share/doc/find-the-command/ftc.fish


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history burası
#function history
#builtin history --show-time='%F %T '
#end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | string trim --right --chars=/)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Cleanup local orphaned packages
function cleanup
    while pacman -Qdtq
        sudo pacman -R (pacman -Qdtq)
    end
end

## Useful aliases

# Replace ls with eza
alias ll 'eza -al --color=always --group-directories-first --icons' # preferred listing
alias la 'eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ls 'eza -l --color=always --group --icons'  # long format
alias lt 'eza -aT --color=always --group-directories-first --icons' # tree listing
alias l. 'eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles

# Replace some more things with better alternatives
#alias cat 'bat --style header --style snip --style changes --style header'
#if not test -x /usr/bin/yay; and test -x /usr/bin/paru
#    alias yay 'paru'
#end


# Common use
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias big 'expac -H M "%m\t%n" | sort -h | nl'     # Sort installed packages according to size in MB (expac must be installed)
alias dir 'dir --color=auto'
alias fixpacman 'sudo rm /var/lib/pacman/db.lck'
alias gitpkg 'pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias grep 'ugrep --color=auto'
alias egrep 'ugrep -E --color=auto'
alias fgrep 'ugrep -F --color=auto'
alias grubup 'sudo update-grub'
alias hw 'hwinfo --short'                          # Hardware Info
alias ip 'ip -color'
alias psmem 'ps auxf | sort -nr -k 4'
alias psmem10 'ps auxf | sort -nr -k 4 | head -10'
alias rmpkg 'sudo pacman -Rdd'
alias tarnow 'tar -acf '
alias untar 'tar -zxvf '
alias upd '/usr/bin/garuda-update'
alias vdir 'vdir --color=auto'
alias wget 'wget -c '

# Get fastest mirrors
alias mirror 'sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist'
alias mirrora 'sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist'
alias mirrord 'sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist'
alias mirrors 'sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist'

# Help people new to Arch
alias apt 'man pacman'
alias apt-get 'man pacman'
alias please 'sudo'
alias tb 'nc termbin.com 9999'
alias helpme 'echo "To print basic information about a command use tldr <command>"'
alias pacdiff 'sudo -H DIFFPROG=meld pacdiff'

export LIBVIRT_DEFAULT_URI="qemu:///system"


# Get the error messages from journalctl
alias jctl 'journalctl -p 3 -xb'

# Recent installed packages
alias rip 'expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -200 | nl'

# Run fastfetch if session is interactive
if status --is-interactive && type -q fastfetch
#    fastfetch --load-config dracula
#    fastfetch
      neofetch 
end

### SHORTCUTS ###
alias vi='nvim'
alias vim='nvim'
alias wg-up='sudo wg-quick up wg0'
alias wg-down='sudo wg-quick down wg0'
alias whoiss='ps aux | grep pts'
alias secheaders='~/.local/bin/secheaders'
alias myhistory='bash ~/GIT/myhistory/myhistory.sh'
alias upsacle='flatpak run io.gitlab.theevilskeleton.Upscaler'

### ALIAS ###

alias du='du -sh'
alias bcat='bat'

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

function kset
    set ns $argv[1]
    kubectl config set-context --current --namespace=$ns
end

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
export KUBECONFIG=/home/shyuuhei/.kube/foxhound.yaml
export HISTFILE=/home/shyuuhei/.local/share/fish/fish_history
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S "
export HISTSIZE=1000
export HISTFILESIZE=2000

## GLOBAL ENV ##
