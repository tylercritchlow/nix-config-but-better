# Coding CLIs.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cursor-cli
    codex
    grok-bot
  ];
}
