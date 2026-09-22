{ pkgs, ... }:
{
  packages = with pkgs; [ neovim ];
  message = "Railscasts";
}
