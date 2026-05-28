{ config, lib, pkgs, ... }:
let
  de = "plasma"; # "gnome" ya "plasma"
in
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim git gh neovim helix tmux zoxide unzip wget
    google-chrome discord distrobox docker
    boxbuddy tela-icon-theme ntfs3g
    mangohud btop fish fastfetch yazi eza
    ptyxis android-studio zed-editor vscode direnv nixd
    brave
  ]
  ++ lib.optionals (de == "gnome") [
    gnome-tweaks gnome-extension-manager
  ]
  ++ lib.optionals (de == "plasma") [
    kdePackages.kate kdePackages.kcalc kdePackages.filelight
  ];
}
