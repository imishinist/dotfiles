
set -x GPG_TTY $(tty)

if test -d /opt/cuda
  fish_add_path /opt/cuda/bin
end
