{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "$USER";

    homeDirectory =
      if pkgs.stdenv.isLinux then
        "/home/$USER"
      else
        "/Users/$USER";
  };
  imports = [
    ./emacs
    ./git
    ./starship
    ./tmux
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    act
    awscli2
    bat
    cargo
    clang
    clangStdenv
    coreutils
    ffmpeg
    fd
    fish
    fzf
    gh
    ghq
    gnused
    go
    google-cloud-sdk
    htop
    hyperfine
    imagemagick
    jq
    kubectl
    moreutils
    mosh
    netcat
    niv
    nodejs
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    okteto
    openjdk
    pkg-config
    protobuf
    python2
    python3
    ripgrep
    rnix-lsp
    rustc
    starship
    tree
    unzip
    tmux
    watch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  programs.bash = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "fzf";
          rev = "479fa67d7439b23095e01b64987ae79a91a4e283";
          sha256 = "28QW/WTLckR4lEfHv6dSotwkAKpNJFCShxmKFGQQ1Ew=";
        };
      }
    ];
    shellInit = ''
      set fish_greeting

      set -x LANG "ja_JP.UTF-8"
      set -x LC_CTYPE ja_JP.UTF-8

      # Nix
      if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      end
      # End Nix
    '';
    shellAliases = {
      en = "emacsclient -nw -a \"\"";
      em = "emacsclient --create-frame -a \"\"";
      ekill = "emacsclient -e \"(kill-emacs)\"";
      vi = "nvim";
      vim = "nvim";
    };
    functions = {
      fdd = "cd (ghq list --full-path | fzf --layout reverse)";
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
      bindkey -e
    '';
  };
}
