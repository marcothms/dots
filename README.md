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

## 日本語入力
With `ibus-anthy` under GNOME use:
+ `GTK_IM_MODULE=ibus`
+ `QT_IM_MODULE=ibus`
+ `XMODIFIERS=@im=ibus`

With `fcitx5` under `sway` use:
+ `GTK_IM_MODULE=fcitx5`
+ `QT_IM_MODULE=fcitx5`
+ `SDL_IM_MODULE=fcitx5`
+ `GLFW_IM_MODULE=ibus`
+ `XMODIFIERS="@im=fcitx5"`
