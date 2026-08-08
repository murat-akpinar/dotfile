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

## Hyprland Kısayolları

`SUPER` = `$mainMod`. Vim yönleri: `H` sol, `J` aşağı, `K` yukarı, `L` sağ.

> **Not:** Kısayollar `hyprland/settings.json` içindeki `keybinds` dizisinden üretilir.
> `hyprland/config/keybindings.conf` **otomatik üretilen** bir dosyadır — elle düzenlenirse
> `scripts/settings_watcher.sh` bir sonraki çalışmasında üzerine yazar.

### Pencere Yönetimi
| Kısayol | İşlem |
| --- | --- |
| `SUPER + ← / → / ↑ / ↓` | Pencereleri yer değiştir (swap) |
| `SUPER + CTRL + H/J/K/L` | Odağı taşı |
| `SUPER + SHIFT + H/J/K/L` | Pencereyi boyutlandır (50px adım, basılı tutulabilir) |
| `SUPER + SHIFT + F` | Tam ekran |
| `SUPER + SHIFT + SPACE` | Floating aç/kapat |
| `SUPER + Q` | Pencereyi kapat |
| `SUPER + TAB` | Diğer monitöre geç |
| `SUPER + sol tık sürükle` | Pencereyi taşı |
| `SUPER + sağ tık sürükle` | Pencereyi boyutlandır |

> Boyutlandırma ve odak neden ok tuşlarında değil: dahili ThinkPad klavyesinde
> `SUPER + <modifier> + sağ ok` kombinasyonu klavye matrisinde raporlanmıyor (ghosting).
> Ok tuşları bu yüzden yalnızca tek modifier ile, üçlü kombinasyonlar harf tuşlarıyla kullanılıyor.

### Çalışma Alanları
| Kısayol | İşlem |
| --- | --- |
| `SUPER + 1…0` | Çalışma alanına geç (1-10) |
| `SUPER + SHIFT + 1…0` | Pencereyi çalışma alanına taşı |
| `3 parmak yatay kaydırma` | Çalışma alanları arasında geçiş |

### Uygulamalar
| Kısayol | İşlem |
| --- | --- |
| `SUPER + T` | Terminal (kitty) |
| `SUPER + F` | Tarayıcı (zen-browser) |
| `SUPER + E` | Dosya yöneticisi (nautilus) |
| `SUPER + C` | VS Code |
| `SUPER + I` | Uygulama başlatıcı |
| `SUPER + R` | Hyprland yapılandırmasını yeniden yükle |

### Quickshell Panelleri
| Kısayol | İşlem |
| --- | --- |
| `SUPER + M` | Müzik |
| `SUPER + B` | Batarya |
| `SUPER + W` | Duvar kağıdı seçici |
| `SUPER + S` | Takvim |
| `SUPER + N` | Ağ |
| `SUPER + V` | Pano geçmişi |
| `SUPER + P` | Filmler |
| `SUPER + H` | Yardım / kılavuz |
| `SUPER + SHIFT + S` | Ayarlar |
| `SUPER + SHIFT + T` | Odak zamanlayıcı |

### Ekran Görüntüsü
| Kısayol | İşlem |
| --- | --- |
| `Print` | Bölge seç |
| `SHIFT + Print` | Bölge seç, ardından düzenle |
| `SUPER + Print` | Tam ekran |
| `SUPER + SHIFT + Print` | Tam ekran, ardından düzenle |

### Medya ve Sistem
| Kısayol | İşlem |
| --- | --- |
| `SUPER + SPACE` | Oynat / duraklat |
| `Oynat / Duraklat` (medya tuşu) | Oynat / duraklat |
| `Ses Aç / Kıs` | Ses seviyesi (OSD ile) |
| `Ses Kapat` | Sesi sustur |
| `Mikrofon Kapat` | Mikrofonu sustur |
| `Parlaklık Aç / Kıs` | Ekran parlaklığı (OSD ile) |
| `Caps Lock` | Caps Lock durum göstergesi |
| `SUPER + L` | Ekranı kilitle |
| `Güç tuşu` | Ekranı kilitle |

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
## Todo+ Kullanım Notları
```bash

| Kısayol            | İşlem                                |
| ------------------ | ------------------------------------ |
| `:`                | Todo başlık oluşturur                |
| `Ctrl + Enter`     | Todo checkbox oluştur                |
| `Alt + Enter`      | Todo checkbox oluştur                |
| `Alt + D`          | Todo'yu tamamlandı olarak işaretle   |
| `Alt + C`          | Todo'yu iptal edildi olarak işaretle |
| `Alt + S`          | Todo'yu başlat                       |
```
