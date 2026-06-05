{ config, pkgs, ... }:
{
  home-manager.users.das = {
    home.username = "das";
    home.homeDirectory = "/home/das";
    home.stateVersion = "26.05";

    programs.git = {
      enable = true;
      userName = "ananddub";
      userEmail = "duanand6@gmail.com";
    };

    programs.npm = {
      enable = true;
      settings.prefix = "$HOME/.npm-global";
    };

    home.sessionPath = [ "$HOME/.npm-global/bin" ];

    programs.home-manager.enable = true;
  };
}
