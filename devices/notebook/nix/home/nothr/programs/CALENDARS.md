# Calendars and Syncthing

Apply the notebook configuration from the repository root:

```sh
sudo nixos-rebuild switch --flake path:./devices/notebook/nix#notebook
```

## iCloud

At https://account.apple.com generate an app-specific password (requires
Apple two-factor authentication). Do not use your normal Apple password.

Store credentials locally, not in this repository or a Nix expression. Run
`bash` first if your current shell is Fish, then run:

```bash
install -d -m 700 ~/.config/vdirsyncer
(umask 077
 read -r -p 'Apple account email: ' apple_user
 printf '%s' "$apple_user" > ~/.config/vdirsyncer/icloud-username
 read -r -s -p 'Apple app-specific password: ' apple_password
 printf '\n'
 printf '%s' "$apple_password" > ~/.config/vdirsyncer/icloud-password
)
vdirsyncer discover icloud
vdirsyncer metasync icloud
vdirsyncer sync icloud
```

Accept creation of local calendars when discovery prompts. After a successful
first sync, enable automatic sync every 15 minutes:

```sh
touch ~/.config/vdirsyncer/icloud-enabled
systemctl --user start vdirsyncer.service
```

`khal list` shows upcoming events; `ikhal` opens the interactive calendar.
The default calendar, `personal`, is **local only**. Select an iCloud calendar
explicitly when creating events to upload them. iCloud sync is bidirectional:
changes and deletions can propagate to iCloud. Back up important calendars.

Troubleshoot with `journalctl --user -u vdirsyncer.service`.
Remove `~/.config/vdirsyncer/icloud-enabled` to pause automatic sync.
Credentials are permission-restricted plaintext files, not encrypted storage.

## Google Calendar (Gmail)

Not configured yet: Google's CalDAV endpoint requires OAuth, not your Gmail
password or an app password. vdirsyncer's `google_calendar` storage needs a
Google Cloud OAuth client ID/client secret and an interactive authorization.
Google Calendar's CalDAV API must be enabled for that project. Keep OAuth
credentials and tokens outside Nix/the repository. Once a client is available,
a separate Google storage/pair and khal discovery path can be added.

A private Google iCalendar subscription is an alternative for read-only
access. Treat that URL as a secret; it grants access to the calendar.

## Proton Calendar

Proton does not provide a CalDAV endpoint, and Proton Mail Bridge does not
add calendar support. Use Proton Calendar's web/mobile app for normal editing.
Where your Proton plan supports sharing a calendar via a link, a read-only
subscription may be possible; it is not two-way sync. Shared URLs are secrets
and expose calendar data outside Proton's normal encrypted client workflow.
An exported ICS file can also be imported into a local khal calendar, but
this is a snapshot, not ongoing synchronization.

## Syncthing

The user service starts automatically with your login session. Open
http://127.0.0.1:8384 to pair devices and choose folders; neither is preselected.
The admin UI is bound to localhost only. No firewall ports are opened here;
if direct connections fail, review the firewall/network settings.

Do not sync the vdirsyncer credential files or calendar database via Syncthing.
Use CalDAV for calendar synchronization instead.
