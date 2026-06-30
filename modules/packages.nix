{ config, lib, pkgs, ... }:
let
  de = "gnome"; # "gnome" ya "plasma"
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    vim git gh neovim helix tmux zoxide unzip wget fzf starship bat atuin just broot fd dust ripgrep bottom navi
    google-chrome discord distrobox docker
    boxbuddy tela-icon-theme ntfs3g
    mangohud btop nvtopPackages.nvidia fish fastfetch yazi eza
    ptyxis zed-editor vscode direnv nixd
    brave heroic nodejs_latest home-manager tailscale iosevka
    androidStudioPackages.stable  telegram-desktop jetbrains.idea jetbrains.goland  
    gnumake net-tools  kubectl xorriso dnsmasq lima-full netbird-ui gh rustup
  
  ]
  ++ lib.optionals (de == "gnome") [
    gnome-tweaks gnome-extension-manager
  ]
  ++ lib.optionals (de == "plasma") [
    kdePackages.kate kdePackages.kcalc kdePackages.filelight
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  
}
