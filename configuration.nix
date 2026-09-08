{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./shell.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";

  environment.systemPackages = with pkgs; [
       vim
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
       mihomo
       tmux
  ];

  system.stateVersion = "26.05"; # Did you read the comment?

  # For xxw'settings
  users.users.xxw = {
    isNormalUser = true;
    description = "xxw";
    extraGroups = [ "wheel" "networkmanager" "adbusers" ];
    #initPasswordHash = "xxw"
    home = "/home/xxw";
  };

  # Open SSH Port On 22
  services.openssh = {
    enable = true;
    ports = [ 22 ];
  };

  # Allow UnFree softwore
  nixpkgs.config.allowUnfree = true;
  
  #Install nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];

  # Installl linux-zen
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Fcitx5
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      qt6Packages.fcitx5-chinese-addons
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
  ];

  # Change xxw's Shell to Zsh
  users.users.xxw = {
    shell = pkgs.zsh;
  };
  
  # Gnome I Think Gnome Is Verry Pretty In Default))))
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  # mihomo
  security.wrappers.mihomo = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_admin,cap_net_bind_service+ep";
    source = "${pkgs.mihomo}/bin/mihomo";
  };

  networking.networkmanager.insertNameservers = [ "127.0.0.1" ];
}


