# my dotfiles

Everything is managed via `stow(1)`:

```bash
$ ./stow.sh 
Use ./stow.sh --stow <folder_name> to deploy configuration
Use ./stow.sh --unstow <folder_name> to remove configuration
```

### Quirks
- Install based on Fedora Workstation with GNOME
- Font: [JetBrains Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip)
- Keyboard Layout: EurKey
- Keepass should use `/run/user/1000/keyring/ssh` as SSH Auth Socket
- Keyring provided by GNOME and started with sway
- Environment Vairables exported using systemd in [envvars.conf](files/environment/.config/environment.d/envvars.conf)
- Lenovo Conservation Mode without root
  ```bash
  %wheel ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/bus/platform/drivers/ideapad_acpi/VPC????\:??/conservation_mode
  ```
- Brave Flags for Wayland
  ```bash
  /usr/bin/brave-browser-stable --enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4 --enable-wayland-ime --enable-features=TouchpadOverscrollHistoryNavigation
  ```
- Remove Client Side Decorations
  ```bash
  $ gsettings get org.gnome.desktop.wm.preferences button-layout
  'icon:close'
  $ gsettings set org.gnome.desktop.wm.preferences button-layout ''
  ```

### Software via dnf

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

### Software via GitHub

- [sway fork - swayfx](https://github.com/WillPower3309/swayfx)
- [notification daemon + popup - swaync](https://github.com/ErikReider/SwayNotificationCenter)
- [application launcher - tofi](https://github.com/philj56/tofi)
- [screenshot tool](https://github.com/moverest/sway-interactive-screenshot) (checked in [here](files/sway/.config/sway/screenshot))
- [screen mirror for live presentations](https://github.com/Ferdi265/wl-mirror)
