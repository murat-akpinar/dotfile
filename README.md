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
murat@pxe[192.168.1.154 ]:/home/murat $>
````
````bash
echo 'export PS1="\[\e[01;33m\]\u\[\e[m\]@\[\e[0;1;92m\]\h\[\e[m\]\[\e[01;35m\][\$(hostname -I | awk '\''{print $1}'\'')]\[\e[0m\]:\[\e[01;36m\]\$PWD\[\e[m\] \[\e[01;31m\]\\$>\[\e[m\] "' >> ~/.bashrc
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
