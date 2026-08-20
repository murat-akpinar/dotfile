# tmux

Prefix'e basıp bırakıp ikinci tuşa basma (`prefix + tuş`) akışı yerine **tek akorlu**
kısayollar. Prefix yalnızca nadir komutlar için duruyor.

## Kurulum
```bash
ln -sf ~/GIT/dotfile/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/GIT/dotfile/tmux/fish_user_key_bindings.fish ~/.config/fish/functions/fish_user_key_bindings.fish
tmux source-file ~/.tmux.conf   # sadece calisan server icin; yeni server zaten kendi okur
exec fish
```

## Kısayollar
| Tuş | İşlev |
| --- | --- |
| `Alt + H` | Sola böl |
| `Alt + L` | Sağa böl |
| `Alt + K` | Yukarı böl |
| `Alt + J` | Aşağı böl |
| `Ctrl + ← ↓ ↑ →` | Pane'ler arası gezinme |
| `Alt + X` | Pane'i kapat (y/n onayı sorar) |
| `Alt + D` | Detach |
| `Ctrl + Space` | Prefix — nadir komutlar (`c` yeni window, `?` kısayol listesi, `[` copy-mode) |
| `Prefix + R` | Yapılandırmayı yeniden yükle |

Yeni pane'ler mevcut pane'in dizininde açılır (`-c "#{pane_current_path}"`).

## Fish çakışmaları

`bind -n` ile bağlanan tuşlar shell'e hiç ulaşmaz, yani tmux'un aldığı her tuş fish'ten
çalınmış olur. Çakışan fish işlevleri yeni tuşlara taşındı —
`fish_user_key_bindings.fish` bunu yapıyor:

| Yeni tuş | İşlev | Eski tuş |
| --- | --- | --- |
| `Alt + M` | `man` sayfası | `Alt + H` |
| `Alt + I` | Dizin içeriğini listele | `Alt + L` |
| `Alt + ,` | kill-word | `Alt + D` |

## Tuş seçimlerinin gerekçesi

- **Prefix neden `Ctrl+Space`:** Hyprland düz `Ctrl`'de hiçbir şey tutmuyor
  (`$mainMod = SUPER`, bir de `ALT+SPACE`). Fish'in `ctrl-space` bind'i sadece boşluk
  ekliyor — space tuşu zaten yapıyor, kayıp yok.
- **Detach neden `Alt+D`, `Ctrl+D` değil:** `Ctrl+D` fish'te EOF/`exit`. Prefix'siz
  bağlanırsa hiçbir shell'den, python REPL'inden veya `cat`'ten çıkılamaz.
- **Bölme neden `Ctrl+H/J/K/L` değil:** `Ctrl+H` terminalde birebir Backspace (`^H`),
  `Ctrl+J` birebir Enter (`^J`). Aynı byte'lar, ayırt edilemez.
- **Gezinme neden `Ctrl`+oklar:** `Alt`+oklar fish'te dizin geçmişi ve history token
  arama (değerli), `Shift`+sol/sağ dolu. `Ctrl`+oklardan yalnızca token atlama gidiyor,
  onu da `Alt`+oklar kelime atlama olarak zaten karşılıyor.
- **`Ctrl+Shift+D` neden değil:** Terminal eski encoding'de `Ctrl+D` ile
  `Ctrl+Shift+D`'yi ayırt edemiyor. Ancak kitty keyboard protocol +
  `set -s extended-keys on` ile çalışıyor, yani tek terminale bağımlı hale geliyor.
