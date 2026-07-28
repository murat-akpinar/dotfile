# Dotfile
### Oh My Posh terminal.conf dosyası
Kurulurken font seçme yerine geldiğinizde **Symbols Nerd Font Mon** seçmelisiniz.
Kullandığım fontlar;
- UbuntuMono Nerd Font 
- Ubuntu Nerd Font Propo Bold 12 size.

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



## Garuda Linux Fish



## vscode eklentileir
```bash
birdlinux.catppuccin-dark-theme
thang-nm.flow-icons
includable.file-duplicate
firejump.frame-indent-rainbow
mhutchie.git-graph
bierner.markdown-preview-github-styles
wayou.vscode-todo-highlight
fabiospampinato.vscode-todo-plus
```
