export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

ssh-add -D
dbus-send --type=method_call --dest=org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock
