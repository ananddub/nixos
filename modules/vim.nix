{config,lib,pkgs,...}:
{
  programs.neovim = {
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}