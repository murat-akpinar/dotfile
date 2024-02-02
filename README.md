# dotfile
Oh My Posh terminal tema dosyası
Symbols Nerd Font Mon + UbuntuMono Nerd Font = Ubuntu Nerd Font Propo Bold 12 size

````bash

{
  "type": "kubectl",
  "style": "powerline",
  "powerline_symbol": "\ue602",
  "foreground": "#000000",
  "background": "#282a36 ",
  "template": "\udb84\udcfe {{.Context}}{{if .Namespace}} :: {{.Namespace}}{{end}} ",
  "properties": {
    "context_aliases": {
      "arn:aws:eks:eu-west-1:1234567890:cluster/posh": "posh"
    }
  }
},

````
