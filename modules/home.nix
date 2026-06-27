{ config, pkgs, ... }:
let
  homeDir = config.home-manager.users.das.home.homeDirectory;
in
{
  home-manager.users.das = {
    home.username = "das";
    home.homeDirectory = "/home/das";
    home.stateVersion = "26.05";

    programs.git = {
      enable = true;
      settings.user.name = "ananddub";
      settings.user.email = "duanand6@gmail.com";
    };

    programs.npm = {
      enable = true;
      settings.prefix = "${homeDir}/.npm-global";
    };

    home.sessionPath = [ "$HOME/.npm-global/bin" ];

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };

    programs.home-manager.enable = true;
  };
}
