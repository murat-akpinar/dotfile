# dotfile
Oh My Posh terminal tema dosyası
Symbols Nerd Font Mon + UbuntuMono Nerd Font = Ubuntu Nerd Font Propo Bold 12 size


network'e bağlı contailarları listleer
docker network inspect --format='{{range .Containers}} {{.Name}} {{end}}' web

contaiların ip adresini verir
docker inspect -f '{{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' nginx-container

