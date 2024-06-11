{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
    	url = "github:nix-community/home-manager/release-24.05";
    	inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  # outputs = { self, nixpkgs, ... }@inputs: {
    ## Please replace my-nixos with your hostname
    # nixosConfigurations.jelly-os = nixpkgs.lib.nixosSystem {
      # system = "x86_64-linux";
      # modules = [
        ## Import the previous configuration.nix we used,
        ## so the old configuration file still takes effect
        # ./configuration.nix
      # ];
    # };
  # };
  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
          # TODO please change the hostname to your own
      jelly-os = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO replace ryan with your own username
            home-manager.users.puggi = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
         };
  };
}
