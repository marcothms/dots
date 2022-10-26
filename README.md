# my dots

dots for my laptop 「itomori」, managed with `gnu stow`.

Files can be `stow`'ed and un'`stow`'ed with `stow.sh`.
It will link all dotfiles to their correct place.

## fonts
Fonts are provided in `fonts/`.
SFMono also provides icons.

## ssh-agent(1)
Move `ssh-agent.service` to `~/.config/systemd/user/ssh-agent.service`
and start it appropriately.
Only used in sway.

## deps
### for sway
+ `waybar`
+ `SwayNotificationCenter`
+ `wob` (progress bar; audio, brightness)
+ `wofi` (program launcher) 
+ `slurp`, `grim`, `swappy` (screenshot)
+ `swaylock-effects` (fancy locker)
+ [`wmrctl`](https://git.sr.ht/~brocellous/wlrctl) (advanced window switcher)

### other
+ `fzf`
+ `ripgrep` (`nvim` needs this)
+ `ripgrep-all` (used in `wofi`; `sway`)
+ `fd` (rust find; used in `sway` and `nvim`)
+ all `fcitx5` stuff (data, gtk, qt, mozc)

### theming stuff (sway)
+ main bg: #323232
+ accent: #93b259
+ icons: `Flat-Remix-Green-Light-darkPanel` (from `flat-remix-icon-theme`)
+ theme: `Flat-Remix-GTK-Green-Light-solid` with adjusted accent
  + or `/usr/share/themes/Flat-Remix-Marc`

## 日本語入力
With `fcitx5` under `sway` use:
+ `GTK_IM_MODULE=fcitx5`
+ `QT_IM_MODULE=fcitx5`
+ `SDL_IM_MODULE=fcitx5`
+ `GLFW_IM_MODULE=ibus`
+ `XMODIFIERS="@im=fcitx5"`

With `ibus-anthy` under GNOME use:
+ `GTK_IM_MODULE=ibus`
+ `QT_IM_MODULE=ibus`
+ `XMODIFIERS=@im=ibus`
