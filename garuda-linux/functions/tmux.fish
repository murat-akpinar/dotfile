# Kurulum: ~/.config/fish/functions/tmux.fish (fish otomatik yukler)
# `tmux -S NAME` -> `tmux new -A -s NAME`: soket hep varsayilan
# (/tmp/tmux-$UID/default), boylece `tmux ls` / `tmux a` her dizinden gorur.
# -A: oturum varsa baglanir, yoksa olusturur.
# Gercek -S (ozel soket dosyasi) gerekirse: command tmux -S /yol/soket ...
function tmux --wraps tmux
    if test "$argv[1]" = -S; and set -q argv[2]
        set -e argv[1]
        command tmux new -A -s $argv
    else
        command tmux $argv
    end
end
