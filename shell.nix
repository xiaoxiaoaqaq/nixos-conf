{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zsh-powerlevel10k ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 200000;
    shellAliases = {
      ll = "ls -l";
      la = "ls -lah";
      update = "sudo nixos-rebuild switch";
      vim = "nvim";
      f = "fastfetch";
      c = "clear";
      cf = "clear&&fastfetch";
    };
    setOptions = [
      "AUTO_CD"
    ];
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "dirhistory" "history" ];
    };
  };
  users.defaultUserShell = pkgs.zsh;
  system.userActivationScripts.zshrc = "touch .zshrc";
  environment.shells = with pkgs; [ zsh ];
}
