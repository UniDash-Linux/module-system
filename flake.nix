{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = inputs @ { self, nixpkgs, home-manager }: {
    configsImports.base.graphical = {
      home = ./src/base/graphical/home;
      system = ./src/base/graphical/system;
    };
  };
}
