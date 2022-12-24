{ pkgs, ... }:

{
    programs.tmux = {
        enable = true;
    };

    home.file.".tmux.conf".text = builtins.readFile ./.tmux.conf;
}