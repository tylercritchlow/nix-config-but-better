# Ghostty terminal.
{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "FiraCode Nerd Font Mono";
      font-style = "Regular";
      font-size = 16;
      background = "#1d2021";
      foreground = "#ebdbb2";
      background-opacity = 0.9;
      window-width = 133;
      window-height = 40;
    };
  };
}
