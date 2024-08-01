# my dotfiles

Everything is managed via `stow(1)`.

```bash
$ ./stow.sh 
Unknown option, exiting.
Use ./stow.sh --stow <folder_name> to deploy configuration
Use ./stow.sh --unstow <folder_name> to remove configuration
```

Remove CSD for browser, etc.:
```bash
$ gsettings get org.gnome.desktop.wm.preferences button-layout
'icon:close'
$ gsettings set org.gnome.desktop.wm.preferences button-layout ''
```


# Dependencies

Font: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip

```
sudo dnf install \
  kitty git vim tmux ripgrep fd-find fzf stow \
  sway waybar \
  brightnessctl \
  wofi \
  pasystray \
  network-manager network-manager-applet \
  nextcloud \
  keepassxc \
  fcitx5 fcitx5-configtool fcitx5-anthy \
```

- https://github.com/ErikReider/SwayNotificationCenter
- https://github.com/moverest/sway-interactive-screenshot
- https://github.com/bjesus/wttrbar
- https://github.com/Ferdi265/wl-mirror
