{ config, lib, pkgs, ... }:
{
  programs.bash.completion.enable = true;
  programs.bash.enableLsColors = true;
  programs.bash.blesh.enable = true;
  
  programs.bash.interactiveShellInit = ''
    if [[ ''${BLE_VERSION-} ]]; then
      ble-bind -f up   'history-search-backward hide-if-empty'
      ble-bind -f down 'history-search-forward hide-if-empty'
    fi

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
    eval "$(starship init bash)"
    eval "$(atuin init bash)"
    eval "$(navi widget bash)"
    source <(fzf --bash)
    export PATH="$HOME/.local/bin:$PATH"
    export ANDROID_HOME=/run/media/das/SSD/AndroidSdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export PATH="$HOME/.npm-global/bin:$PATH"
    alias cat="bat --paging=never"
  '';

  programs.bash.shellAliases = {
    rebuild = "sudo nixos-rebuild switch";
    find = "fd";
    grep = "rg";
    du = "dust";
    top = "btm";
    tree = "broot";
    btop = "btop --force-utf";
    cd = "z";
    ls = "eza --icons";
    ll = "eza -l --icons";
    la = "eza -la --icons";
  };
}