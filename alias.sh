echo "alias ll='ls -lvrt'" >> ~/.bashrc

echo "alias cdd='cd ..'" >> ~/.bashrc
echo "alias cddd='cd ../..'" >> ~/.bashrc


echo "alias du='du -sh *'" >> ~/.bashrc


echo "alias bcat='batcat'" >> ~/.bashrc
echo "alias chng='find . -print0 | xargs -0 stat -c "%Z %z %n" | sort -nr | head -10'" >> ~/.bashrc

#### DOCKER #####
alias dc='docker compose'
alias di='docker images'
alias dcdel='docker container rm $(docker container ls -aq)'
#### DOCKER ####



source ~/.bashrc

