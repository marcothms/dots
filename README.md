# my dots

dots for my laptop 「itomori」, managed with `gnu stow`.

Files can be `stow`'ed and un'`stow`'ed with `stow.sh`.
It will link all dotfiles to their correct place.

## fonts
Fonts are provided in `fonts/`
SFMono also provides icons.

## ssh-agent(1)
Move `ssh-agent.service` to `~/.config/systemd/user/ssh-agent.service`
and start it appropriately.

## deps
### for sway
+ `waybar`
+ `SwayNotificationCenter`
+ `wob` (progress bar)
+ `wofi` (launcher)
+ `slurp`, `grim`, `swappy` (screenshot)
+ `swaylock-effects`
+ [`wmrctl`](https://git.sr.ht/~brocellous/wlrctl) (window switcher)

### other (used in scripts)
+ `fzf` (used in many places)
+ `ripgrep`
+ `ripgrep-all` (used in grep scripts)
+ `fd` (rust find; used in scripts)
+ all `fcitx5` stuff (data, gtk, qt, mozc)

### theming stuff
+ main bg: #323232
+ accent: #93b259
+ icons: `Flat-Remix-Green-Light-darkPanel` (from `flat-remix-icon-theme`)
+ theme: `Flat-Remix-GTK-Green-Light-solid` with adjusted accent
  + or `/usr/share/themes/Flat-Remix-Marc`

