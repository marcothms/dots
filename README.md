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


### Dependencies (and quirks)

#### General
- Install based on Fedora Workstation with GNOME
- Font: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
- `keepassxc(1)` should use `/run/user/1000/keyring/ssh` as SSH Auth Socket
- Env Vars exported via `systemd` in `files/environment/.config/environment.d/envvars.conf`
- Toogle conservation without root: `%wheel ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/bus/platform/drivers/ideapad_acpi/VPC????\:??/conservation_mode`
- Brave Flags for Wayland: `/usr/bin/brave-browser-stable --enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4 --enable-wayland-ime --enable-features=TouchpadOverscrollHistoryNavigation`

#### Sway
- Keyring provided by GNOME and started with `sway(1)`

```
sudo dnf install \
  kitty git vim tmux ripgrep fd-find fzf stow \
  brave \
  sway waybar \
  brightnessctl wireplumber pasystray blueman \
  network-manager network-manager-applet \
  fcitx5 fcitx5-configtool fcitx5-anthy fcitx5-* \
  nextcloud keepassxc
```

- sway fork: https://github.com/WillPower3309/swayfx
- application launcher: https://github.com/philj56/tofi
- notification daemon + popup: https://github.com/ErikReider/SwayNotificationCenter
- screenshot: https://github.com/moverest/sway-interactive-screenshot (checked in as `files/sway/.config/sway/screenshot`)
- screen mirror for live presentations: https://github.com/Ferdi265/wl-mirror
- vpn: https://netbird.io/