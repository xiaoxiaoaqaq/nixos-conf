{
  environment.systemPackages = with pkgs; [
       vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
       wget
       htop
       fastfetch
       neovim
       zsh
       git
       kitty
       google-chrome
       #linuxqq
       curl
       unzip
       #7zip
       #fcitx5
       opencode
       android-tools
       matugen
       python3
       gnome-console
  ];
}

