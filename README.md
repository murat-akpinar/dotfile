# Dotfile

## Dizin Yapısı
| Dizin | İçerik |
| --- | --- |
| `common/` | Platformdan bağımsız genel ayarlar (alias, oh-my-posh teması, kurulum scripti) |
| `starship/` | Starship prompt ayarları — `starship.toml` genel, `garuda.toml` Garuda varyantı, `catppuccin.toml` Catppuccin teması |
| `fastfetch/` | Fastfetch ayarları (distro bağımsız) |
| `neofetch/` | Neofetch ayarları (distro bağımsız) |
| `windows/` | Windows'a özel ayarlar (PowerShell profili, Windows Terminal) |
| `garuda-linux/` | Garuda Linux / KDE'ye özel ayarlar |
| `hyprland/` | Hyprland masaüstü ortamına özel ayarlar |
| `docs/` | Notlar ve tek satırlık scriptler |

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


## vscode eklentileir
```bash
- Theme
birdlinux.catppuccin-dark-theme

- ICON
thang-nm.flow-icons

- TOOLS
includable.file-duplicate
firejump.frame-indent-rainbow
mhutchie.git-graph
bierner.markdown-preview-github-style
maciejdems.add-to-gitignore

- TODO
fabiospampinato.vscode-todo-plus
wayou.vscode-todo-highlight

```

## vscode settings
```bash
.vscode
 - settings.json
```
```bash
{
  // todo.md is a Todo+ file; the extension does not claim *.md by itself.
  "files.associations": {
    "todo.md": "todo"
  },
  // Dates the extension writes match the ones the repo already uses.
  "todo.timekeeping.started.format": "YYYY-MM-DD HH:mm",
  "todo.timekeeping.finished.format": "YYYY-MM-DD"
}

```
