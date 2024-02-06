# Dotfile
### Oh My Posh terminal.conf dosyası
Kurulurken font seçme yerine geldiğinizde **Symbols Nerd Font Mon** seçmelisiniz.
Kullandığım fontlar;
- UbuntuMono Nerd Font 
- Ubuntu Nerd Font Propo Bold 12 size.
### örnek görüntü

![ornek](https://i.hizliresim.com/eqea1m5.png)

### Vim Ayarları
Vim girinti eklentisi
````bash
git clone https://github.com/Yggdroot/indentLine.git ~/.vim/pack/vendor/start/indentLine
vim -u NONE -c "helptags  ~/.vim/pack/vendor/start/indentLine/doc" -c "q"
````

Vim satır sayılarını gösterme
````bash
echo ':set relativenumber' >> ~/.vim/vimrc
````
