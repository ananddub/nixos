{ config, lib, pkgs, ... }:
let
  de = "gnome"; # "gnome" ya "plasma"
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    vim git gh neovim helix tmux zoxide unzip wget
    google-chrome discord distrobox docker
    boxbuddy tela-icon-theme ntfs3g
    mangohud btop fish fastfetch yazi eza
    ptyxis zed-editor vscode direnv nixd
    brave heroic nodejs_latest home-manager tailscale iosevka
    androidStudioPackages.stable  telegram-desktop jetbrains.idea jetbrains.goland 
  ]
  ++ lib.optionals (de == "gnome") [
    gnome-tweaks gnome-extension-manager
  ]
  ++ lib.optionals (de == "plasma") [
    kdePackages.kate kdePackages.kcalc kdePackages.filelight
  ];
  
}
