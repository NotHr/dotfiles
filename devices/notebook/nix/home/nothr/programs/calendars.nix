{ config, lib, pkgs, ... }:
let
  calendarDir = "${config.xdg.dataHome}/calendars";
  syncDir = "${config.xdg.configHome}/vdirsyncer";
in
{
  services.vdirsyncer = {
    enable = true;
    frequency = "*:0/15";
  };

  # Opt in only after credentials and initial discovery have been completed.
  systemd.user.services.vdirsyncer.Unit.ConditionPathExists = [
    "${syncDir}/icloud-username"
    "${syncDir}/icloud-password"
    "${syncDir}/icloud-enabled"
  ];

  xdg.configFile."vdirsyncer/config".text = ''
    [general]
    status_path = "${config.xdg.stateHome}/vdirsyncer/status/"

    [pair icloud]
    a = "icloud_local"
    b = "icloud_remote"
    collections = ["from b"]
    metadata = ["displayname", "color"]

    [storage icloud_local]
    type = "filesystem"
    path = "${calendarDir}/icloud/"
    fileext = ".ics"

    [storage icloud_remote]
    type = "caldav"
    url = "https://caldav.icloud.com/"
    username.fetch = ["command", "${pkgs.coreutils}/bin/cat", "${syncDir}/icloud-username"]
    password.fetch = ["command", "${pkgs.coreutils}/bin/cat", "${syncDir}/icloud-password"]
  '';

  xdg.configFile."khal/config".text = ''
    [calendars]
    [[personal]]
    path = ${calendarDir}/personal/
    type = calendar
    color = light blue

    [[icloud]]
    path = ${calendarDir}/icloud/*
    type = discover

    [default]
    default_calendar = personal
    highlight_event_days = True

    [locale]
    timeformat = %H:%M
    dateformat = %Y-%m-%d
    longdateformat = %Y-%m-%d
    datetimeformat = %Y-%m-%d %H:%M
    longdatetimeformat = %Y-%m-%d %H:%M
  '';

  home.activation.calendarDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${pkgs.coreutils}/bin/mkdir -p \
      ${lib.escapeShellArg "${calendarDir}/personal"} \
      ${lib.escapeShellArg "${calendarDir}/icloud"}
  '';
}
