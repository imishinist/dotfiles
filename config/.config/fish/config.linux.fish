
set -x GPG_TTY $(tty)

if [ -d /opt/cuda ]; then
    set -x PATH $PATH /opt/cuda/bin
fi

