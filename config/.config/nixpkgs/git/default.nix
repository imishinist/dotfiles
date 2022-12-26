{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    git
    diff-so-fancy
  ];

  home.file.".gitconfig".source = config.lib.file.mkOutOfStoreSymlink ./.gitconfig;
  home.file.".gitignore".source = config.lib.file.mkOutOfStoreSymlink ./.gitignore;
}
