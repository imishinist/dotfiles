alias tailscale "/Applications/Tailscale.app/Contents/MacOS/Tailscale"

set -x GPG_TTY $(tty)

if [ -d "$HOME/.config/op" ]; then
  source /home/taisuke/.config/op/plugins.sh
fi
