# my dots

dots for my laptop 「itomori」, managed with `gnu stow`.
Files can be `stow`'ed and un'`stow`'ed with `stow.sh`.
It will link all dotfiles to their correct place.
Un-`stow` with `./stow.sh -D`.

## deps
+ `fzf` (`zsh`, `nvim`)
+ `ripgrep` (`nvim`)
+ `fd` (rust find; `nvim`)

Also run `checkhealth` in `nvim` after a first install

## laptop
laptop uses `Xft.dpi: 192`

## gnome-terminal

$ dconf dump /org/gnome/terminal/legacy/profiles:/ > gnome-terminal.dconf
$ dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal.dconf
