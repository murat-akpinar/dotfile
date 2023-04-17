#!/bin/bash
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://raw.githubusercontent.com/magwyen/dotfile/main/mytheme.omp.json -P ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
echo 'eval "$(oh-my-posh init bash)"' >> ~/.profile
echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/mytheme.omp.json)"' >> ~/.profile
echo 'eval "$(oh-my-posh init bash)"' >> ~/.bashrc
echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/mytheme.omp.json)"' >> ~/.bashrc
oh-my-posh font install
exec bash
