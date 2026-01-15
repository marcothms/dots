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
  io.github.ungoogled_software.ungoogled_chromium \
  io.gitlab.librewolf-community \
  org.prismlauncher.PrismLauncher
```

```
sudo snap install \
  zotero-snap \
  proton-mail \
  obsidian \
  codium
```

### Manual

- [Helix](https://github.com/helix-editor/helix/releases)
- [Signal](https://signal.org/download/linux/)
- Rust: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
- Nix:
  ```
  $ sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
  $ mkdir -p ~/.config/nix/
  $ echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
  ```

## Extensions

### Custom
- blur-my-shell@aunetx (blur panel and background in overview, rest disabled)
- caffeine@patapon.info
- compiz-alike-magic-lamp-effect@hermes83.github.com
- gnome-ui-tune@itstime.tech (desktop thumbnails scale 300%, show search)
- gsconnect@andyholmes.github.io
- ideapad@laurento.frittella
- rounded-window-corners@fxgn (rounded corners of all windows)
- rounded-corners (12px)
- tilingshell@ferrarodomenico.com (4 inner, 0 outer, super+wasd, span all super+f, center super+c, cycle super+tab)
- user-theme@gnome-shell-extensions.gcampax.github.com (legacy apps adw-gtk3, icons papirus)
- quick-settings-audio-panel
- quicksettings-audio-devices-hider (in the main panel)

### Pre-installed
- disable desktop icons
- disable tiling-assistant
- dock (bottom, no panel, disable keyshortcuts)
