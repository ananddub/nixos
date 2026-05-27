{ config, lib, pkgs, ... }:
{
  programs.bash.enableCompletion = true; 
  programs.bash.enableLsColors = true;
  programs.bash.blesh.enable = true;

  
  programs.bash.shellInit =  ''
    eval "$(zoxide init bash)"

    
  '';
  programs.bash.shellAliases = {
    rebuild = "sudo nixos-rebuild switch";
    cd = "z";
  };
}