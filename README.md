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
