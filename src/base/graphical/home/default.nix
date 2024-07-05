{ username, ... }:
{ pkgs, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    ## Config ------------------------------------------------------ ##
    ./gtk
    ./background
  
    ## Apps -------------------------------------------------------- ##
    ./kitty
    ./btop
    ./tmux
    ./libreoffice

    ## System ------------------------------------------------------ ##
    ./rofi
    ./waybar
    ./lockscreen
    ./writableConfigs
    ./hyprland/hyprland
    ./hyprland/hyprlandColor

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
