
alias en 'emacsclient -nw -a ""'
alias em 'emacsclient --create-frame -a ""'
alias ekill 'emacsclient -e "(kill-emacs)"'
alias emacs '/Applications/Emacs.app/Contents/MacOS/Emacs'

# variables
set -gx SDKROOT $(xcrun --show-sdk-path)


# path
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

fish_add_path /opt/homebrew/opt/llvm/bin

set --local gnubin_path $(brew --prefix)/opt/coreutils/libexec/gnubin
if [ -f {$gnubin_path} ]; fish_add_path $gnubin_path; end

