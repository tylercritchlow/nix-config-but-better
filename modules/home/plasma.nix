{ ... }:
{
  programs.plasma = {
    enable = true;
    immutableByDefault = true;

    workspace.lookAndFeel = "org.kde.breezedark.desktop";

    krunner.position = "center";

    panels = [
      {
        height = 46;
        floating = true;
        widgets = [
          { kickoff = { }; }
          { pager = { }; }
          {
            iconTasks.launchers = [
              "applications:systemsettings.desktop"
              "applications:firefox.desktop"
              "preferred://filemanager"
              "applications:com.mitchellh.ghostty.desktop"
              "applications:steam.desktop"
            ];
          }
          { name = "org.kde.plasma.marginsseparator"; }
          {
            systemTray.items.shown = [
              "org.kde.plasma.notifications"
              "org.kde.plasma.clipboard"
              "org.kde.plasma.volume"
              "org.kde.plasma.networkmanagement"
            ];
          }
          { digitalClock = { }; }
          { name = "org.kde.plasma.showdesktop"; }
        ];
      }
    ];

    configFile = {
      kdeglobals.General.BrowserApplication = "firefox.desktop";

      kwinrc."Effect-overview".BorderActivate = 9;

      powerdevilrc = {
        "AC][Display".DimDisplayIdleTimeoutSec = 120;
        "AC][Display".TurnOffDisplayWhenIdle = false;
        "AC][Performance".PowerProfile = "performance";
      };

      kcminputrc.Keyboard.RepeatDelay = 800;

      ksmserverrc.General.loginMode = "emptySession";
    };
  };
}
