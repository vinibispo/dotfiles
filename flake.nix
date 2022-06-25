{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "vinionrails";
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit system username;
        homeDirectory = "/home/${username}";
        configuration = { config, pkgs, ... }: {
          programs.home-manager.enable = true;

          home.file.".config/nix/nix.conf".text = ''
            experimental-features = nix-command flakes
          '';

          home.packages = with pkgs; [
          curl
          wget
         nodejs-18_x
          ripgrep
          rsync
          ];
          programs.git = {
            enable = true;
            userName = "vinibispo";
            userEmail = "vini.bispo015@gmail.com";
          };
          programs.lazygit = {
            enable = true;
            settings.gui.theme.lightTheme = true;
          };
        };
      };
    };
}
