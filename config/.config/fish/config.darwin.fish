alias tailscale "/Applications/Tailscale.app/Contents/MacOS/Tailscale"

set -x GPG_TTY $(tty)

if test -d "$HOME/.config/op"
  source $HOME/.config/op/plugins.sh
end
