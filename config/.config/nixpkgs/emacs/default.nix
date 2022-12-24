{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
  };

  xdg.configFile."emacs/init.el".text = builtins.readFile ./init.el;
}