{ hostname, username }:
{ pkgs, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    ## Config ------------------------------------------------------ ##
    ./extra_files
    ./gtk
    ./background
  
    ## Apps -------------------------------------------------------- ##
    ./kitty
    ./btop
    ./tmux
    ./git
    ./libreoffice

    ## System ------------------------------------------------------ ##
    ./fish
    ./rofi
    ./waybar
    ./lockscreen
    ./writable_configs
    ./hyprland/hyprland
    ./hyprland/hyprland_color

    ## Other-------------------------------------------------------- ##
    ./programs.nix
  ];

############
# Packages #
#######################################################################
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    ## ------------------------------------------------------------- ##
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "ide";
    };
    sessionPath = [
      "/home/${username}/.local/bin/"
      "/home/${username}/.npm-global/"
    ];
    ## ------------------------------------------------------------- ##
    packages = with pkgs; [
      ### Settings ------------------------------------------------ ###
      brightnessctl
      rofi-wayland
      rofi-bluetooth
      rofi-wpa
      rofi-mixer
      libnotify
      dunst
      btop
      xdg-user-dirs
      acpi
      maim
      looking-glass-client
      font-fixer
      (pkgs.callPackage ./hyprwal { })
      xorg.xhost
      global-fullscreen
      linuxKernel.packages.linux_latest_libre.v4l2loopback

      ### Volume -------------------------------------------------- ###
      pavucontrol
      rofi-pulse-select
      pulseaudio

      ### Misc ---------------------------------------------------- ###
      krita
      libreoffice
      onlyoffice-bin_latest
      gnome.file-roller
      qpdfview
      mpc-cli
      firefox
      viewnior
      cinnamon.nemo-with-extensions
      rofi-hyprshot
      rofi-power

      ### Utils --------------------------------------------------- ###
      galculator
      calc
      imagemagick
      kitty
    ];
  };
#######################################################################
}
