{ username, ... }:
{ pkgs, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    ## Config ------------------------------------------------------ ##
    ./gtk
  
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
    ./hyprland
    ./wal

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
      xdg-user-dirs
      acpi
      maim
      font-fixer
      (pkgs.callPackage ./hyprwal { })
      xorg.xhost
      global-fullscreen
      linuxKernel.packages.linux_latest_libre.v4l2loopback

      ### Volume -------------------------------------------------- ###
      rofi-pulse-select
      pulseaudio

      ### Misc ---------------------------------------------------- ###
      mpc-cli
      rofi-hyprshot
      rofi-power

      ### Utils --------------------------------------------------- ###
      calc
      imagemagick
    ];
  };
#######################################################################
}
