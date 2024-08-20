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


### Dependencies

- Install based on Fedora Workstation with GNOME (makes everything easier)
- Font: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
- Keyring provided by GNOME and startet in `sway(1)`
- `keepassxc(1)` should use `/run/user/1000/keyring/ssh` as SSH Auth Socket
- Env Vars exported via `systemd` in `files/environment/.config/environment.d/envvars.conf`

```
sudo dnf install \
  kitty git vim tmux ripgrep fd-find fzf stow \
  brave \
  sway waybar wofi \
  brightnessctl wireplumber pasystray \
  network-manager network-manager-applet \
  fcitx5 fcitx5-configtool fcitx5-anthy fcitx5-* \
  nextcloud keepassxc
```

- notification daemon + popup: https://github.com/ErikReider/SwayNotificationCenter
- screenshot: https://github.com/moverest/sway-interactive-screenshot (checked in as `files/sway/.config/sway/screenshot`)
- weather info in bar: https://github.com/bjesus/wttrbar
- screen mirror for live presentations: https://github.com/Ferdi265/wl-mirror
- vpn: https://netbird.io/