
# variables
set -gx SDKROOT $(xcrun --show-sdk-path)


# path
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

fish_add_path /opt/homebrew/opt/llvm/bin

set --local gnubin_path $(brew --prefix)/opt/coreutils/libexec/gnubin
if [ -f {$gnubin_path} ]; fish_add_path $gnubin_path; end

