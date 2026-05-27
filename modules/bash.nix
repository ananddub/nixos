{ config, lib, pkgs, ... }:
{
  programs.bash.enableCompletion = true; 
  programs.bash.enableLsColors = true;
  programs.bash.blesh.enable = true;

  
  programs.bash.promptPluginInit  =  ''
    eval "$(zoxide init bash)"
    export PATH="$HOME/.local/bin:$PATH"
  '';

  programs.bash.shellAliases = {
    rebuild = "sudo nixos-rebuild switch";
    cd = "z";
  };
}