# Dotfile
### Oh My Posh terminal.conf dosyası
Kurulurken font seçme yerine geldiğinizde **Symbols Nerd Font Mon** seçmelisiniz.
Kullandığım fontlar;
- UbuntuMono Nerd Font 
- Ubuntu Nerd Font Propo Bold 12 size.
### örnek görüntü

![ornek](https://r.resimlink.com/fS9c_Rr68.png)

### Vim Ayarları
Vim girinti eklentisi
````bash
git clone https://github.com/Yggdroot/indentLine.git ~/.vim/pack/vendor/start/indentLine
vim -u NONE -c "helptags  ~/.vim/pack/vendor/start/indentLine/doc" -c "q"
````

Vim satır sayılarını gösterme
````bash
echo ':set number' >> ~/.vim/vimrc
````

ip adresli ekstra bir kurulum gerektirmeyen
````bash
murat@OutherHaven[192.168.49.179] ~ >
````
````bash
echo 'export PS1="\[\e[38;5;48m\]\u\[\e[m\]\[\e[38;5;141m\]@\[\e[38;5;206m\]\h\[\e[38;5;203m\][\$(hostname -I | awk '\''{print \$1}'\'')]\[\e[m\]\[\e[38;5;215m\] \w\[\e[38;5;141m\] > \[\e[m\]"' >> ~/.bashrc

````
vscode eklentileir
```bash
includable.file-duplicate
firejump.frame-indent-rainbow
mhutchie.git-graph
redhat.ansible
bierner.markdown-preview-github-styles
PKief.material-icon-theme
redhat.vscode-yaml
```
