# dotfile
Oh My Posh terminal tema dosyası
Symbols Nerd Font Mon + UbuntuMono Nerd Font = Ubuntu Nerd Font Propo Bold 12 size


network'e bağlı contailarları listleer

````bash
docker network inspect --format='{{range .Containers}} {{.Name}} {{end}}' network-ismi
````

contaiların ip adresini verir
````bash
docker inspect -f '{{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' container-ismi
````
