#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir -p ~/.poshthemes
cp "$SCRIPT_DIR/mytheme.omp.json" ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*

echo 'eval "$(oh-my-posh init bash)"' >> ~/.bashrc
echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/mytheme.omp.json)"' >> ~/.bashrc
oh-my-posh font install
exec bash
