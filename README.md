# Dotfile
### Oh My Posh terminal.conf dosyası
Kurulurken font seçme yerine geldiğinizde **Symbols Nerd Font Mon** seçmelisiniz.
Kullandığım fontlar;
- UbuntuMono Nerd Font 
- Ubuntu Nerd Font Propo Bold 12 size.
![oh-my-posh](https://r.resimlink.com/jr3M1q5mleaZ.png)

### Vim Ayarları
- Vim girinti eklentisi
````bash
git clone https://github.com/Yggdroot/indentLine.git ~/.vim/pack/vendor/start/indentLine
vim -u NONE -c "helptags  ~/.vim/pack/vendor/start/indentLine/doc" -c "q"
````
- Vim satır sayılarını gösterme
````bash
echo ':set number' >> ~/.vim/vimrc
````


## IP Adresli PS1
````bash
echo 'export PS1="\[\e[38;5;48m\]\u\[\e[m\]\[\e[38;5;141m\]@\[\e[38;5;206m\]\h\[\e[38;5;203m\][\$(hostname -I | awk '\''{print \$1}'\'')]\[\e[m\]\[\e[38;5;215m\] \w\[\e[38;5;141m\] > \[\e[m\]"' >> ~/.bashrc
````
![bash](https://r.resimlink.com/sK2BH3kI1T.png)


## Garuda Linux Fish

![garuda-linux-fish](https://r.resimlink.com/7AemkCHE62Q0.png)

## vscode eklentileir
```bash
includable.file-duplicate 
firejump.frame-indent-rainbow // oderwat.indent-rainbow
mhutchie.git-graph
redhat.ansible
bierner.markdown-preview-github-styles
PKief.material-icon-theme
redhat.vscode-yaml
starkwang.markdown
xcad2k.vscode-thedigitallife
```
