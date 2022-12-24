{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
  ];

  home.file.".gitconfig".text = builtins.readFile ./.gitconfig;
  home.file.".gitignore".text = builtins.readFile ./.gitignore;
}
