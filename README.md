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
- Environment Vairables exported using systemd in [envvars.conf](files/environment/.config/environment.d/envvars.conf)
- Lenovo Conservation Mode without root
  ```bash
  %wheel ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/bus/platform/drivers/ideapad_acpi/VPC????\:??/conservation_mode
  ```

### Software

```
sudo dnf install \
  kitty tmux \
  git ripgrep fd-find fzf stow \
  firefox \
  obsidian \
  nextcloud keepassxc tailscale
```

[Helix](https://github.com/helix-editor/helix/releases)


### Extensions
- appindicatorsupport@rgcjonas.gmail.com (bring back tray icons)
- blur-my-shell@aunetx (blur panel and background in overview, rest disabled)
- caffeine@patapon.info (don't sleep on fullscreen)
- compiz-alike-magic-lamp-effect@hermes83.github.com (minimize animation)
- gnome-ui-tune@itstime.tech (desktop thumbnails scale 300%, show search)
- gsconnect@andyholmes.github.io (connect android for file share)
- ideapad@laurento.frittella (lenovo conservation mode)
- light-style@gnome-shell-extensions.gcampax.github.com (everything light mode)
- rounded-window-corners@fxgn (rounded corners of all windows)
- tiling-assistant@leleat-on-github (2 gaps, tiling state, super+wasd)
- user-theme@gnome-shell-extensions.gcampax.github.com (legacy apps adw-gtk3, icons papirus)


### Nix

```
$ sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
$ mkdir -p ~/.config/nix/
$ echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

### Rust

```
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
