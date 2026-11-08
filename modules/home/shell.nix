{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    shellAliases = {
      mydate = "date +\"%m/%d/%Y\"";
    };
    initContent = ''
      if [[ -o interactive && -z "$TMUX" && "$TERM_PROGRAM" == "ghostty" ]]; then
        exec ${pkgs.tmux}/bin/tmux new-session -A -s main
      fi
    '';
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.direnv.enable = true;

  programs.tmux = {
    enable = true;
    shortcut = "n";
    mouse = true;
    terminal = "screen-256color";
    baseIndex = 1;
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
