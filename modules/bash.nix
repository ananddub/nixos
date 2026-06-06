{ config, lib, pkgs, ... }:
{
  programs.bash.completion.enable = true;
  programs.bash.enableLsColors = true;
  programs.bash.blesh.enable = true;
  
  programs.bash.interactiveShellInit = ''
    nix() {
      if [ "$1" = "flake" ] && [ "$2" = "init" ] && [ -n "$3" ] && [[ "$3" != -* ]]; then
        command nix flake init -t "github:the-nix-way/dev-templates#$3"
        direnv allow
      else
        command nix "$@"
      fi
    }
  '';

  programs.bash.promptPluginInit  =  ''
    eval "$(zoxide init bash)"
    eval "$(direnv hook bash)"
    export PATH="$HOME/.local/bin:$PATH"
    export ANDROID_HOME=$HOME/Android/Sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export PATH="$HOME/.npm-global/bin:$PATH"

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