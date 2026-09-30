{ config, pkgs, ... }:

{
  home.username = "xxw";
  # home.homeDirectory = "/home/xxw/";

  home.packages = with pkgs;[
    which
    tree
    zstd
    sing-box
    wine
  ];

  programs.git = {
    enable = true;
    userName = "xiaoxiaoaqaq";
    userEmail = "3219634304@qq.com";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO 在这里添加你的自定义 bashrc 内容
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # TODO 设置一些别名方便使用，你可以根据自己的需要进行增删
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      update = "sudo nixos-rebuild switch";
      f = "fastfetch";
      c = "clear";
      cf = "clear&&fastfetch";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}
