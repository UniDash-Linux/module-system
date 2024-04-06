{
###########
# Imports #
#######################################################################
  description = "Pikatsuto dotfiles";
  # ----------------------------------------------------------------- #
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    ## ------------------------------------------------------------- ##
    hosts.url = "github:StevenBlack/hosts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    ## ------------------------------------------------------------- ##
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
#############
# Variables #
#######################################################################
  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    hosts,
    ...
  } @inputs: let
    username = "gabriel";
    system = "x86_64-linux";
    hostname = "NixAchu";

    applyAttrNames = builtins.mapAttrs (name: f: f name);

    computers = applyAttrNames {
      "${hostname}-Fix" = self: {
        hostname = "${self}";
        vm = {
          cores = 4;
          threads = 2;
          memory = 12;
          diskSize = 512;
          diskPath = "/var/lib/libvirt/images";
          restartDm = false;
          videoVirtio = false;
          pcies = [
            {
              pcie = {
                vmBus = "09";
                bus = "01";
                slot = "00";
                function = "0";
              };
              driver = ''nouveau'';
              blacklistDriver = true;
            }
            {
              pcie = {
                vmBus = "09";
                bus = "01";
                slot = "00";
                function = "1";
              };
              driver = ''nouveau'';
              blacklistDriver = true;
            }
            {
              pcie = {
                vmBus = "09";
                bus = "01";
                slot = "00";
                function = "2";
              };
              driver = ''nouveau'';
              blacklistDriver = true;
            }
            {
              pcie = {
                vmBus = "09";
                bus = "01";
                slot = "00";
                function = "3";
              };
              driver = ''nouveau'';
              blacklistDriver = true;
            }
          ];
        };
        modules = [];
      };
      ### --------------------------------------------------------- ### 
      "${hostname}-Lap" = self: {
        hostname = "${self}";
        vm = {
          cores = 2;
          threads = 2;
          memory = 8;
          diskSize = 128;
          diskPath = "/home/${username}/VM/Disk";
          restartDm = false;
          videoVirtio = true;
          pcies = false;
        };
        modules = [
          nixos-hardware.nixosModules.asus-battery
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
        ];
      };
    };
    ## ------------------------------------------------------------- ##
    default_modules = [
      hosts.nixosModule {
        networking.stevenBlackHosts = {
          blockFakenews = true;
          blockGambling = true;
          blockPorn = false;
          blockSocial = true;
        };
      }
    ];
##########
# Config #
#######################################################################
  in
  {
    nixosConfigurations = (nixpkgs.lib.genAttrs (builtins.attrNames computers)
    (name: nixpkgs.lib.nixosSystem {
      inherit system;
      #### ----------------------------------------------------- ####
      modules = default_modules ++ computers."${name}".modules ++ [
        (import ./computer.nix {
          computer = computers."${name}";
          inherit username home-manager;
        })
      ];
    }));
  };
#######################################################################
}
