# Git + SSH configuration.
{
  pkgs,
  me,
  ...
}:
{
  programs.git = {
    enable = true;
    signing.format = null;
    settings.user.email = me.email;
    settings.user.name = me.fullname;
    settings.push.autoSetupRemote = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        SendEnv = [
          "LANG"
          "LC_*"
        ];
      };
      "ssh.critchlow.net" = {
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
        ProxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
    };
  };
}
