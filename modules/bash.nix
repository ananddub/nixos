{ config, lib, pkgs, ... }:
{
  programs.bash.enableCompletion = true;
  programs.bash.enableLsColors = true;
  programs.bash.blesh.enable = true;
  
  programs.bash.promptPluginInit  =  ''
    eval "$(zoxide init bash)"
    eval "$(direnv hook bash)"
    export PATH="$HOME/.local/bin:$PATH"
    export ANDROID_HOME=$HOME/Android/Sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
  '';

  programs.bash.shellAliases = {
    rebuild = "sudo nixos-rebuild switch";
    btop = "btop --force-utf";
    cd = "z";
    ls = "eza --icons";
    ll = "eza -l --icons";
    la = "eza -la --icons";
  };
}