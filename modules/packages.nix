{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim git gh neovim helix tmux zoxide unzip wget
    gnome-tweaks gnome-extension-manager
    google-chrome discord distrobox docker
    boxbuddy tela-icon-theme ntfs3g
    mangohud btop fish fastfetch yazi eza
    ptyxis android-studio zed-editor vscode direnv nixd
    btop   brave
  ];
}
