# my dotfiles

Everything is managed via `stow(1)`:

```bash
$ ./stow.sh 
Use ./stow.sh --stow <folder_name> to deploy configuration
Use ./stow.sh --unstow <folder_name> to remove configuration
```

## Quirks
- Install based on Ubuntu Desktop
- Font: [BlexMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IBMPlexMono.zip)
- Keyboard Layout: EurKey (enable extended in gnome-tweaks)
- Environment Vairables exported using systemd in [envvars.conf](files/environment/.config/environment.d/envvars.conf)
- LibreWolf from flatpak needs devices=all to read yubikeys
- Lenovo Conservation Mode without root
  ```bash
  %wheel ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/bus/platform/drivers/ideapad_acpi/VPC????\:??/conservation_mode
  ```
- Switch workspaces: `for i in {1..9}; do gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']";done`
- Don't open pinned apps: `for i in {1..9}; do gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]";done`
- https://github.com/fzwoch/obs-vaapi
  - mkv, ffmpeg vaapi av1, ffmpeg aac
  - main, auto, vbr, 10.000 - 30.000, 0s
  - native res, no canvas scaling
- kdenlive proxy: x264-vaapi-scale

## Software

### Basics
```
sudo apt install \
  kitty tmux \
  git ripgrep fd-find fzf stow
```

### Extended

```
sudo apt install \
  pympress \
  gnome-tweaks \
  gimp darktable obs-studio kdenlive
```

```
flatpak install \
  com.belmoussaoui.Authenticator \
  com.github.tchx84.Flatseal \
  com.mastermindzh.tidal-hifi \
  dev.vencord.Vesktop \
  org.prismlauncher.PrismLauncher
```

```
sudo snap install \
  zotero-snap \
  proton-mail \
  obsidian \
  codium \
  steam
```

### Custom config

```
sudo snap connect steam:audio-record :audio-record
```

### Manual

- [Helix](https://github.com/helix-editor/helix/releases)
- [Signal](https://signal.org/download/linux/)
- [Brave](https://brave.com/linux/)
- [Rust](https://rustup.rs/)
- [Nix](https://nixos.org/download/) (single-user installation)
  ```
  # additionally, enable flakes
  $ mkdir -p ~/.config/nix/
  $ echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
  ```

## Extensions

### Custom
- caffeine@patapon.info
- gsconnect@andyholmes.github.io
- rounded-window-corners@fxgn (12px)
- tilingshell@ferrarodomenico.com (disable snap assistant, 4 inner, 0 outer, super+wasd, span all super+f, center super+c, cycle super+tab)
- user-theme@gnome-shell-extensions.gcampax.github.com (legacy apps adw-gtk3, icons papirus)
- quick-settings-audio-panel
- quicksettings-audio-devices-hider (hide unused devices)

### Pre-installed
- disable desktop icons
- disable tiling-assistant
- disable dock
- ubuntu-appindicators (disable x11 legacy)
