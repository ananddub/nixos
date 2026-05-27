{ config, lib, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
    extraPackages = with pkgs; [ freetype ];
  };
  programs.gamemode.enable = true;
}
